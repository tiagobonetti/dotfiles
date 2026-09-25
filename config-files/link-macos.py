#!/usr/bin/env python3
import argparse

from link_utils import link, unlink

# Map dotfiles to symlink locations
CONFIGS = {
    "zsh": [{"dotfile": "zshrc", "symlink": ".zshrc"}],
    "neovim-vim": [
        {
            "dotfile": "init.vim",
            "symlink": ".config/nvim/init.vim",
        }
    ],
    "neovim-lua": [
        {
            "dotfile": "init.lua",
            "symlink": ".config/nvim/init.lua",
        }
    ],
    "spacevim": [
        {
            "dotfile": "spacevim-init.toml",
            "symlink": ".SpaceVim.d/init.toml",
        }
    ],
    "ideavim": [
        {
            "dotfile": "ideavimrc",
            "symlink": ".ideavimrc",
        }
    ],
    "opencode": [
        {
            "dotfile": "opencode-config.json",
            "symlink": ".config/opencode/config.json",
        }
    ],
    "opencode-agents": [
        {
            "dotfile": "opencode-AGENTS.md",
            "symlink": ".config/opencode/AGENTS.md",
        }
    ],
    "opencode-tui": [
        {
            "dotfile": "opencode-tui.json",
            "symlink": ".config/opencode/tui.json",
        }
    ],
    "opencode-plan-day": [
        {
            "dotfile": "opencode-skills/plan-day",
            "symlink": ".config/opencode/skills/plan-day",
        },
    ],
    "herdr": [
        {
            "dotfile": "herdr-config.toml",
            "symlink": ".config/herdr/config.toml",
        }
    ],
    "ghostty": [
        {
            "dotfile": "ghostty.conf",
            "symlink": "Library/Application Support/com.mitchellh.ghostty/config.ghostty",
        }
    ],
    "lazygit": [
        {
            "dotfile": "lazygit.yml",
            "symlink": "Library/Application Support/lazygit/config.yml",
        }
    ],
}


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
    action = unlink if args.unlink else link
    for config in CONFIGS[args.config]:
        action(**config)


if __name__ == "__main__":
    main()
