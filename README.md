# Laptop Setup

## Apps
- Chrome
- VSCode
- Smart Countdown Timer (App Store)
- Spotify

## Dev Extras
- [Superset.sh](https://superset.sh)
- BBEdit
- Claude
- Claude Code
- oh-my-zsh:
  ```bash
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  ```

## Scripts
Copy these files from the repo to your home directory, preserving the paths:

| Repo path | Destination |
|-----------|-------------|
| `.zshrc` | `~/.zshrc` |
| `.vimrc` | `~/.vimrc` |
| `dev/reset_conda_env.sh` | `~/dev/reset_conda_env.sh` |
| `.claude/skills/resolve-pr-comments/SKILL.md` | `~/.claude/skills/resolve-pr-comments/SKILL.md` |
| `.claude/skills/pr-fix-for-github-issue/SKILL.md` | `~/.claude/skills/pr-fix-for-github-issue/SKILL.md` |

## Packages
- Homebrew: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
- Conda: https://www.anaconda.com/download

## VS Code

Copy settings files from the repo, preserving paths:

| Repo path | Destination |
|-----------|-------------|
| `Library/Application Support/Code/User/settings.json` | `~/Library/Application Support/Code/User/settings.json` |
| `Library/Application Support/Code/User/keybindings.json` | `~/Library/Application Support/Code/User/keybindings.json` |

Key settings: vim mode (uses `.vimrc`), 100-char ruler, no preview tabs, large terminal scrollback, ruff linter, no df row limit, `ctrl+tab` to cycle editors.

## Claude Skills
Skills live at `.claude/skills/` in this repo (mirroring `~/.claude/skills/`):
- `resolve-pr-comments` — fix and resolve all unresolved comments in a GitHub PR
- `pr-fix-for-github-issue` — end-to-end: explore root cause, TDD fix, eval loop, open PR
