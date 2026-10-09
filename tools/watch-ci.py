#!/usr/bin/env python3
"""Watch a GitHub Actions run by run ID or branch name."""

import argparse
import json
import os
import re
import shutil
import subprocess
import sys
from collections.abc import Mapping, Sequence
from typing import Any
from urllib.parse import urlparse


def run_gh(
    *args: str,
    capture_output: bool = False,
    env: Mapping[str, str] | None = None,
) -> subprocess.CompletedProcess[str]:
    try:
        return subprocess.run(
            ["gh", *args],
            check=False,
            capture_output=capture_output,
            text=True,
            env={**os.environ, **env} if env is not None else None,
        )
    except OSError as error:
        raise RuntimeError(
            "GitHub CLI (gh) is not installed or not on PATH."
        ) from error


def run_git(*args: str) -> subprocess.CompletedProcess[str]:
    try:
        return subprocess.run(
            ["git", *args],
            check=False,
            capture_output=True,
            text=True,
        )
    except OSError as error:
        raise RuntimeError("Git is not installed or not on PATH.") from error


def current_branch() -> str:
    result = run_git("branch", "--show-current")
    if result.returncode != 0 or not result.stdout.strip():
        raise RuntimeError(
            "Could not determine the current branch. Run this from a Git checkout "
            "with a checked-out branch, or provide a branch or run ID."
        )
    return result.stdout.strip()


def in_git_checkout() -> bool:
    result = run_git("rev-parse", "--is-inside-work-tree")
    return result.returncode == 0 and result.stdout.strip() == "true"


def origin_repository() -> str:
    result = run_git("remote", "get-url", "origin")
    if result.returncode != 0 or not result.stdout.strip():
        raise RuntimeError(
            "Could not determine the repository from the origin remote. "
            "Run this from a Git checkout with an origin remote, or pass --repo."
        )

    remote = result.stdout.strip()
    if "://" in remote:
        parsed = urlparse(remote)
        host, path = parsed.hostname, parsed.path
    else:
        match = re.fullmatch(r"(?:[^@]+@)?([^:/]+)[:/](.+)", remote)
        if match is None:
            raise RuntimeError(f"Could not parse origin remote URL: {remote}")
        host, path = match.groups()

    path = path.strip("/")
    if path.endswith(".git"):
        path = path[:-4]
    parts = path.split("/")
    if not host or len(parts) != 2 or not all(parts):
        raise RuntimeError(f"Could not determine OWNER/REPO from origin URL: {remote}")
    return f"{host}/{parts[0]}/{parts[1]}"


def resolve_run(target: str, repo: str | None = None) -> str:
    repo_args = ["--repo", repo] if repo else []
    if re.fullmatch(r"[0-9]+", target):
        return target

    result = run_gh(
        "run",
        "list",
        "--branch",
        target,
        "--limit",
        "1",
        "--json",
        "databaseId,headBranch,displayTitle",
        *repo_args,
        capture_output=True,
    )
    if result.returncode != 0:
        detail = result.stderr.strip() or result.stdout.strip()
        raise RuntimeError(detail or "Could not look up runs for that branch.")

    try:
        runs = json.loads(result.stdout)
    except json.JSONDecodeError as error:
        raise RuntimeError(
            "gh returned invalid JSON while looking up the branch."
        ) from error
    if not runs:
        raise RuntimeError(f"No GitHub Actions runs found for branch {target!r}.")
    return str(runs[0]["databaseId"])


def run_details(run_id: str, repo: str | None = None) -> dict[str, Any]:
    repo_args = ["--repo", repo] if repo else []
    result = run_gh(
        "run",
        "view",
        run_id,
        "--json",
        "conclusion,status,displayTitle,url",
        *repo_args,
        capture_output=True,
    )
    if result.returncode != 0:
        detail = result.stderr.strip() or result.stdout.strip()
        raise RuntimeError(detail or f"Could not get final status for run {run_id}.")
    try:
        return json.loads(result.stdout)
    except json.JSONDecodeError as error:
        raise RuntimeError(
            "gh returned invalid JSON while getting the run status."
        ) from error


def notify(title: str, conclusion: str, url: str | None) -> None:
    herdr = shutil.which("herdr")
    if herdr is None:
        print(
            "Notification skipped: herdr is not installed or not on PATH.",
            file=sys.stderr,
        )
        return

    result_title = f"CI {conclusion}: {title}"
    body = f"GitHub Actions run concluded: {conclusion}."
    if url:
        body += f"\n{url}"
    sound = "done" if conclusion == "success" else "request"
    try:
        result = subprocess.run(
            [
                herdr,
                "notification",
                "show",
                result_title,
                "--body",
                body,
                "--sound",
                sound,
            ],
            check=False,
            capture_output=True,
            text=True,
        )
    except OSError as error:
        print(f"Notification failed: {error}", file=sys.stderr)
        return
    if result.returncode != 0:
        detail = result.stderr.strip() or result.stdout.strip()
        print(
            f"Notification failed: {detail or 'herdr notification exited unsuccessfully.'}",
            file=sys.stderr,
        )


def main(argv: Sequence[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "target",
        nargs="?",
        help="GitHub Actions run ID or branch name (defaults to current branch)",
    )
    parser.add_argument(
        "--repo", help="Repository in OWNER/REPO format (defaults to origin remote)"
    )
    parser.add_argument(
        "--interval",
        type=int,
        default=3,
        help="Polling interval in seconds (default: 3)",
    )
    args = parser.parse_args(argv)
    if args.interval < 1:
        parser.error("--interval must be at least 1 second")

    try:
        target = args.target
        repo = args.repo
        if target is None:
            target = current_branch()
        if repo is None and in_git_checkout():
            repo = origin_repository()
        run_id = resolve_run(target, repo)
        print(f"Watching GitHub Actions run {run_id}...")
        repo_args = ["--repo", repo] if repo else []
        watch = run_gh(
            "run",
            "watch",
            run_id,
            "--exit-status",
            "--interval",
            str(args.interval),
            *repo_args,
        )
        details = run_details(run_id, repo)
        status = details.get("status", "unknown")
        conclusion = details.get("conclusion") or status
        title = details.get("displayTitle") or f"Run {run_id}"

        if status != "completed":
            detail = watch.stderr.strip() or watch.stdout.strip()
            raise RuntimeError(
                detail
                or f"Run {run_id} stopped watching before completion (status: {status})."
            )

        if conclusion in {"failure", "timed_out", "startup_failure"}:
            print(
                f"\nRun {run_id} concluded: {conclusion}. Failed logs:\n",
                file=sys.stderr,
            )
            run_gh(
                "run",
                "view",
                run_id,
                "--log-failed",
                *repo_args,
                env={"GH_PAGER": "bat --paging=never"},
            )

        notify(title, conclusion, details.get("url"))
        print(f"Run {run_id} completed: {conclusion}.")
        return 0 if conclusion == "success" else 1
    except RuntimeError as error:
        print(f"watch-ci: {error}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
