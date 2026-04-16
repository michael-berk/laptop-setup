# Laptop Setup

## Apps
- Chrome
- VSCode
- Smart Countdown Timer (App Store)
- Spotify
- Claude
- Claude Code

## Dev Extras
- [Superset.sh](https://superset.sh)
- oh-my-zsh: `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`

## Packages
1. Homebrew — install and add to PATH
2. Miniconda (not full Anaconda) — install, then run `conda init zsh`
3. Claude Code — install via npm
4. GitHub CLI (`gh`) — install, then authenticate via `gh auth login` using HTTPS (not SSH)
5. Set git global `user.name` and `user.email`

## Scripts
Copy these files from the repo to your home directory, preserving paths:

| Repo path | Destination |
|-----------|-------------|
| `.zshrc` | `~/.zshrc` |
| `.vimrc` | `~/.vimrc` |
| `dev/reset_conda_env.sh` | `~/dev/reset_conda_env.sh` |
| `.claude/skills/resolve-pr-comments/SKILL.md` | `~/.claude/skills/resolve-pr-comments/SKILL.md` |
| `.claude/skills/pr-fix-for-github-issue/SKILL.md` | `~/.claude/skills/pr-fix-for-github-issue/SKILL.md` |
| `Library/Application Support/Code/User/settings.json` | `~/Library/Application Support/Code/User/settings.json` |
| `Library/Application Support/Code/User/keybindings.json` | `~/Library/Application Support/Code/User/keybindings.json` |

## Claude Skills
- `resolve-pr-comments` — fix and resolve all unresolved comments in a GitHub PR
- `pr-fix-for-github-issue` — end-to-end: explore root cause, TDD fix, eval loop, open PR
