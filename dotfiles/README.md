# Personal AI-coding dotfiles

Synced harness for **Claude Code** and **Codex CLI** across multiple laptops.
A single source of truth (`shared/profile.md`) drives both tools.

## Layout

```
dotfiles/
├── shared/
│   └── profile.md            # user profile + lesson/research rules — loaded by BOTH tools
├── claude/
│   ├── settings.json         # Claude permissions allowlist
│   └── commands/
│       ├── lesson.md
│       └── research.md
├── codex/
│   ├── config.toml           # Codex approval/sandbox policy
│   └── prompts/
│       ├── lesson.md
│       └── research.md
└── install.sh                # symlinks files into ~/.claude/ and ~/.codex/
```

## Install on a new laptop

```bash
git clone <this-repo-url> ~/dotfiles
cd ~/dotfiles
./install.sh           # both tools
# or:
./install.sh claude    # Claude only
./install.sh codex     # Codex only
```

The installer:
- Symlinks `~/.claude/CLAUDE.md` → `shared/profile.md`
- Symlinks `~/.codex/AGENTS.md`  → `shared/profile.md`
- Symlinks per-tool config and slash-command/prompt files
- Backs up any existing files once into `~/.claude/backup-<timestamp>/`
  or `~/.codex/backup-<timestamp>/`

## Local-only overrides (not tracked)

Per-machine settings — environment-specific hooks, secrets, machine-local
model picks — go here:

- Claude Code: `~/.claude/settings.local.json`
- Codex CLI:   `~/.codex/config.local.toml`

Both tools merge these with the tracked configs at runtime.

## Updating

```bash
cd ~/dotfiles
# edit any file (e.g. shared/profile.md to add a new rule)
git add -A && git commit -m "add X rule" && git push
# other laptop:
git pull   # symlinks already in place; restart your CLI
```

## Single source of truth

Both tools read the same `shared/profile.md` for user profile, lesson-plan
format, and research output rules. Edit it once → both tools see the change
on next session.

## Phone

Both Claude Code and Codex CLI are desktop CLIs; they do not run on
phones. Use the GitHub mobile app to view/edit files in this repo if needed.
