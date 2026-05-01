# Personal Claude Code dotfiles

Synced harness for Claude Code across multiple laptops.

## What's tracked
- `CLAUDE.md` — user-level project memory (loaded every session)
- `settings.json` — permissions allowlist (laptop-safe; no environment-specific hooks)
- `commands/` — slash commands (`/lesson`, `/research`)
- `install.sh` — symlink installer

## Setup on a new laptop

```bash
git clone <this-repo-url> ~/dotfiles-claude
cd ~/dotfiles-claude
./install.sh
```

The installer creates symlinks from `~/.claude/` to files in this repo and
backs up any existing files once into `~/.claude/backup-<timestamp>/`.

## Local-only overrides

For per-machine settings (environment-specific hooks, machine-local
permissions, secrets), use `~/.claude/settings.local.json`. Claude Code
merges it with `~/.claude/settings.json` at runtime, and it is **not**
tracked here.

## Updating

After editing any tracked file (e.g. adding a new slash command),
commit and push:

```bash
cd ~/dotfiles-claude
git add -A
git commit -m "add /<command-name>"
git push
```

On the other laptop:

```bash
cd ~/dotfiles-claude
git pull
# Symlinks already point to repo files — changes apply on next session restart.
```

## Phone

Claude Code is a desktop CLI; it does not run on phones. Use the GitHub
mobile app to view/edit files in this repo if needed.
