#!/usr/bin/env python3
from pathlib import Path
import argparse

# Map dotfiles to symlink locations
# - Keys are dotfiles paths relative to the repo folder
# - Values are symlink names relative to the user home folder
LINKS_DICT = {
    "zshrc": ".zshrc",
    "init.vim": ".config/nvim/init.vim",
    "spacevim-init.toml": ".SpaceVim.d/init.toml",
    "ideavimrc": ".ideavimrc",
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

    source = Path(__file__).resolve().parent / dotfile
    print(f"Creating link '{target}' to '{source}'")
    target.symlink_to(source)


def unlink(symlink: str):
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
    parser = argparse.ArgumentParser(description='Link (or unlink) dotfiles.')
    parser.add_argument('-u', '--unlink', action='store_true',
                        help='unlink dotfiles and restores backups')
    args = parser.parse_args()

    for k, v in LINKS_DICT.items():
        unlink(symlink=k) if args.unlink else link(dotfile=k, symlink=v)


if __name__ == "__main__":
    main()
