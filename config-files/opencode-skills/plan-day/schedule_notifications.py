#!/usr/bin/env python3
"""Inspect and schedule local macOS notifications with terminal-notifier.

Setup and run from this directory::

    .venv/bin/python -m pip install -r requirements.txt
    .venv/bin/python schedule_notifications.py status
    .venv/bin/python schedule_notifications.py list
    .venv/bin/python schedule_notifications.py schedule \
        --at '2026-09-25T16:27' --message 'Event in 3 minutes'

Times passed to ``schedule`` are local Mac times in YYYY-MM-DDTHH:MM format.
The script does not read the calendar feed or store calendar data.
"""

import argparse
from datetime import datetime
import hashlib
import json
import os
import re
import shutil
import subprocess
import sys


def _notifier():
    executable = shutil.which("terminal-notifier")
    if executable is None:
        raise RuntimeError("terminal-notifier is not installed or is not on PATH.")
    return executable


def _run(executable, *args):
    try:
        result = subprocess.run(
            [executable, *args],
            check=False,
            capture_output=True,
            text=True,
            timeout=30,
            env=os.environ.copy(),
        )
    except (OSError, subprocess.TimeoutExpired) as error:
        raise RuntimeError(f"Could not run terminal-notifier: {error}") from error
    if result.returncode != 0:
        detail = result.stderr.strip() or result.stdout.strip()
        raise RuntimeError(detail or f"terminal-notifier exited with status {result.returncode}.")
    return result.stdout.strip()


def _diagnostics(executable):
    output = _run(executable, "-diagnose")
    match = re.search(r"scheduled delivery\s+(not supported|supported)", output, re.IGNORECASE)
    if match is None:
        support = "unknown"
    elif match.group(1).lower() == "supported":
        support = "supported"
    else:
        support = "not supported"
    return output, support


def _status(executable):
    output, support = _diagnostics(executable)
    print(json.dumps({
        "mechanism": "terminal-notifier",
        "available": True,
        "scheduled_delivery": support,
        "diagnostics": output,
    }, ensure_ascii=False))


def _list(executable):
    output = _run(executable, "-list", "PENDING")
    print(output if output else "(no pending notifications)")


def _schedule(executable, local_time, delay, message):
    if local_time:
        try:
            when = datetime.strptime(local_time, "%Y-%m-%dT%H:%M")
        except ValueError as error:
            raise ValueError("--at must be a local time in YYYY-MM-DDTHH:MM format.") from error
        if when <= datetime.now().replace(second=0, microsecond=0):
            raise ValueError("--at must be a future local time.")
        delivery_args = ("-at", when.strftime("%Y-%m-%d %H:%M"))
    else:
        if re.fullmatch(r"[1-9][0-9]*[smhd]", delay) is None:
            raise ValueError("--in must be a positive duration such as 1m, 30s, or 2h.")
        delivery_args = ("-in", delay)

    if not message.strip():
        raise ValueError("--message must not be empty.")

    identifier_data = f"{local_time or delay}\0{message}".encode("utf-8")
    group = "plan-day." + hashlib.sha256(identifier_data).hexdigest()[:24]
    _run(
        executable,
        "-message", message,
        "-title", "Calendar reminder",
        "-group", group,
        *delivery_args,
    )
    pending = _run(executable, "-list", "PENDING")
    match = next((
        columns for line in pending.splitlines()
        if len(columns := line.split("\t")) >= 5
        and columns[0] == group
        and columns[3] == message
    ), None)
    if match is None:
        raise RuntimeError(
            "terminal-notifier returned successfully, but the reminder was not "
            "verified in its pending list."
        )
    print(json.dumps({
        "scheduled": True,
        "time": match[4],
        "message": message,
        "group": group,
    }, ensure_ascii=False))


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    commands = parser.add_subparsers(dest="command", required=True)
    commands.add_parser("status", help="Check macOS notification authorization and alert support")
    commands.add_parser("list", help="List pending local notifications")
    schedule_parser = commands.add_parser("schedule", help="Schedule one approved local reminder")
    timing = schedule_parser.add_mutually_exclusive_group(required=True)
    timing.add_argument("--at", help="Future local time: YYYY-MM-DDTHH:MM")
    timing.add_argument("--in", dest="delay", help="Positive delay such as 1m, 30s, or 2h")
    schedule_parser.add_argument("--message", required=True, help="Exact notification message")
    args = parser.parse_args(argv)

    try:
        executable = _notifier()
        if args.command == "status":
            _status(executable)
        elif args.command == "list":
            _list(executable)
        else:
            _schedule(executable, args.at, args.delay, args.message)
    except Exception as error:
        print(f"Notification error: {error}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
