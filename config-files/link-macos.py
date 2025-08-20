#!/usr/bin/env python3
from pathlib import Path
import argparse

# Map dotfiles to symlink locations
CONFIGS = {
    "zsh": {"dotfile": "zshrc", "symlink": ".zshrc"},
    "neovim-vim": {
        "dotfile": "init.vim",
        "symlink": ".config/nvim/init.vim",
    },
    "neovim-lua": {
        "dotfile": "init.lua",
        "symlink": ".config/nvim/init.lua",
    },
    "spacevim": {
        "dotfile": "spacevim-init.toml",
        "symlink": ".SpaceVim.d/init.toml",
    },
    "ideavim": {
        "dotfile": "ideavimrc",
        "symlink": ".ideavimrc",
    },
    "conan-profile": {
        "dotfile": "conan-profile-macos",
        "symlink": ".conan/profiles/default",
    },
}


def link(dotfile: str, symlink: str):
    target = Path.home() / symlink

    if target.is_symlink():
        print(f"'{target.name}' is a symlink: removing")
        target.unlink()

    elif target.is_file():
        backup = target.with_name(target.name + ".bk")
        print(f"'{target.name}' is a file: making a backup as '{backup}'")
        target.replace(backup)

    target.parent.mkdir(parents=True, exist_ok=True)
    source = Path(__file__).resolve().parent / dotfile
    print(f"Creating link '{target}' to '{source}'")
    target.symlink_to(source)


def unlink(symlink: str, **kwargs):
    target = Path.home() / symlink

    if not target.is_symlink():
        print(f"'{target.name}' isn't a link: ignoring")
        return

    print(f"unlinking '{target.name}'")
    target.unlink()
    backup = target.with_name(target.name + ".bk")
    if backup.is_file():
        print(f"Restoring backup of'{target.name}'")
        backup.replace(target)


def main():
    parser = argparse.ArgumentParser(description="Link (or unlink) dotfiles.")
    parser.add_argument(
        "-u",
        "--unlink",
        action="store_true",
        help="unlink dotfiles and restores backups",
    )
    parser.add_argument(
        "config", choices=CONFIGS.keys(), help="Choose config file to (un)link"
    )

    args = parser.parse_args()
    (unlink if args.unlink else link)(**CONFIGS[args.config])


if __name__ == "__main__":
    main()
