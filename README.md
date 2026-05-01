# Harness Engineering Guide

This branch hosts a worked example of personal Claude Code harness setup, built
during a session on 2026-05-01.

## What's here

- `dotfiles-claude/` — a portable, multi-laptop Claude Code config:
  - `CLAUDE.md` — user-level project memory
  - `settings.json` — permissions allowlist (laptop-safe, no env-specific hooks)
  - `commands/lesson.md`, `commands/research.md` — slash commands
  - `install.sh` — symlink installer
  - `bootstrap.sh` — one-shot creator (regenerates the whole tree from heredocs)
  - `README.md` — usage docs

## Extracting `dotfiles-claude/` into a personal repo

The intent is for `dotfiles-claude/` to live in **its own** GitHub repo so you
can sync it across machines. To extract on your laptop:

```bash
# 1) Clone this branch as a temporary scratch
git clone -b claude/harness-engineering-guide-Domx1 \
  git@github.com:jch2100/harness.git /tmp/harness-extract

# 2) Copy out the dotfiles tree
cp -r /tmp/harness-extract/dotfiles-claude ~/dotfiles-claude
rm -rf /tmp/harness-extract

# 3) Make it a fresh repo
cd ~/dotfiles-claude
git init -b main
git add -A
git commit -m "init: CLAUDE.md, settings, slash commands, installer"

# 4) Create an empty private repo on GitHub (e.g. dotfiles-claude),
#    then push:
git remote add origin git@github.com:<your-username>/dotfiles-claude.git
git push -u origin main

# 5) Install symlinks into ~/.claude/
./install.sh

# 6) Restart Claude Code on this laptop. Verify with the four checks
#    listed in dotfiles-claude/README.md.
```

On laptop 2 onward:

```bash
git clone git@github.com:<your-username>/dotfiles-claude.git ~/dotfiles-claude
cd ~/dotfiles-claude && ./install.sh
```
