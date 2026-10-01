#!/usr/bin/env python3
import argparse

from link_utils import link, unlink

# Map dotfiles to symlink locations
# - Keys are dotfiles paths relative to the repo folder
# - Values are symlink names relative to the user home folder
LINKS_DICT = {
    "gitconfig": ".gitconfig",
    "gitignore-global": ".config/git/ignore",
    "zshrc": ".zshrc",
    "init.vim": ".config/nvim/init.vim",
    "spacevim-init.toml": ".SpaceVim.d/init.toml",
    "ideavimrc": ".ideavimrc",
    "opencode-config.json": ".config/opencode/config.json",
    "opencode-AGENTS.md": ".config/opencode/AGENTS.md",
    "opencode-tui.json": ".config/opencode/tui.json",
    "opencode-skills/plan-day": ".config/opencode/skills/plan-day",
}


def main():
    parser = argparse.ArgumentParser(description='Link (or unlink) dotfiles.')
    parser.add_argument('-u', '--unlink', action='store_true',
                        help='unlink dotfiles and restores backups')
    args = parser.parse_args()

    for k, v in LINKS_DICT.items():
        unlink(symlink=v) if args.unlink else link(dotfile=k, symlink=v)


if __name__ == "__main__":
    main()
