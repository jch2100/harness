# Harness Engineering Guide

This branch hosts a worked example of a personal AI-coding harness, built
across two iterations on 2026-05-01.

## What's here

- `dotfiles/` — a portable, multi-laptop, multi-tool config:
  - `shared/profile.md` — user profile + lesson/research rules (loaded by both tools)
  - `claude/` — Claude Code config (`settings.json`, `commands/`)
  - `codex/`  — Codex CLI config (`config.toml`, `prompts/`)
  - `install.sh` — installs symlinks for both tools (or just one)
  - `README.md` — usage docs

## Extracting `dotfiles/` into a personal repo

The intent is for `dotfiles/` to live in **its own** GitHub repo so you can
sync it across machines. To extract on your laptop:

```bash
# 1) Clone this branch as a temporary scratch
git clone -b claude/harness-engineering-guide-Domx1 \
  git@github.com:jch2100/harness.git /tmp/harness-extract

# 2) Copy out the dotfiles tree
cp -r /tmp/harness-extract/dotfiles ~/dotfiles
rm -rf /tmp/harness-extract

# 3) Make it a fresh repo
cd ~/dotfiles
git init -b main
git add -A
git commit -m "init: shared profile + Claude and Codex configs"

# 4) Create an empty private repo on GitHub (e.g. `dotfiles`), then push:
git remote add origin git@github.com:<your-username>/dotfiles.git
git push -u origin main

# 5) Install symlinks into ~/.claude/ and ~/.codex/
./install.sh
# or selectively:  ./install.sh claude   |   ./install.sh codex

# 6) Restart Claude Code / Codex CLI to load the new config.
```

On any subsequent laptop:

```bash
git clone git@github.com:<your-username>/dotfiles.git ~/dotfiles
cd ~/dotfiles && ./install.sh
```

## Verifying the install

After running `./install.sh` and restarting your CLI:

| Check | Expected |
|---|---|
| New session: "what do you know about my work style?" | Profile content from `shared/profile.md` reflected |
| `ls ~/lessons` | Runs without permission prompt (Claude) / without approval (Codex) |
| `/lesson 광합성 age:12` | Standard 5-section plan saved to `~/lessons/<YYYY>/...md` |
| `/research <topic>` | Cited notes saved to `~/research/...md` |
