#!/usr/bin/env bash
# bootstrap.sh — creates ~/dotfiles-claude/ on a fresh laptop with all
# tracked files. Run this ONCE on laptop 1, then commit/push to your
# own GitHub repo. Laptop 2 onwards just clones and runs install.sh.
set -euo pipefail

DIR="${HOME}/dotfiles-claude"
if [[ -e "$DIR" ]]; then
  echo "Error: $DIR already exists. Aborting." >&2
  exit 1
fi
mkdir -p "$DIR/commands"

cat > "$DIR/CLAUDE.md" <<'EOF'
# User Profile

## Primary work
- Curriculum planning, education research, lesson plan authoring
- Occasional personal-service coding

## Communication
- Respond to the user in Korean
- Code identifiers, comments, config files, and commit messages in English
- File paths and command output: keep as-is

## Lesson plan format
When asked to write a lesson plan, use this structure:
1. Learning objectives (3 items, action verbs)
2. Hook / warm-up (~5 min)
3. Main content (~35 min, 3 sub-sections)
4. Activity (~8 min)
5. Wrap-up & assessment (~2 min)
Default duration: 50 minutes unless specified.
Lesson body language: Korean.

## Research output rules
- Cite every factual claim inline
- End the document with a "References" section
- Prefer primary sources; flag when only secondary sources are available
- Research notes language: Korean

## Defaults
- Save lesson drafts under `~/lessons/<YYYY>/<slug>.md`
- Save research notes under `~/research/<slug>.md`
- Create parent directories if missing
EOF

cat > "$DIR/settings.json" <<'EOF'
{
    "$schema": "https://json.schemastore.org/claude-code-settings.json",
    "permissions": {
        "allow": [
            "Skill",
            "Read(*)",
            "Bash(ls:*)",
            "Bash(cat:*)",
            "Bash(grep:*)",
            "Bash(rg:*)",
            "Bash(find:*)",
            "Bash(wc:*)",
            "Bash(head:*)",
            "Bash(tail:*)",
            "Bash(file:*)",
            "Bash(stat:*)",
            "Bash(pwd)",
            "Bash(tree:*)",
            "Bash(mkdir:*)",
            "Bash(git status)",
            "Bash(git log:*)",
            "Bash(git diff:*)",
            "Bash(git branch:*)",
            "Bash(git show:*)",
            "WebFetch",
            "WebSearch"
        ]
    }
}
EOF

cat > "$DIR/commands/lesson.md" <<'EOF'
---
description: Generate a lesson plan in the standard format
argument-hint: <topic> [age:<N>] [duration:<min>]
---
Generate a lesson plan for: $ARGUMENTS

Follow the lesson-plan format defined in `~/.claude/CLAUDE.md`:
1. Learning objectives (3 items, action verbs)
2. Hook / warm-up (~5 min)
3. Main content (~35 min, 3 sub-sections)
4. Activity (~8 min)
5. Wrap-up & assessment (~2 min)

Default duration: 50 minutes unless `duration:<min>` is given.
Default audience: middle-school unless `age:<N>` is given.
Lesson body language: Korean.

Cite any factual claim inline. End with a "References" section.

Save the result to `~/lessons/<YYYY>/<slug>.md` (slugify the topic, ASCII).
Create parent directories if missing. Report the saved path back to the user in Korean.
EOF

cat > "$DIR/commands/research.md" <<'EOF'
---
description: Run a focused research pass and produce cited notes
argument-hint: <topic>
---
Research the topic: $ARGUMENTS

Use WebSearch and WebFetch to gather sources. Prefer primary sources;
flag clearly when only secondary sources are available.

Produce notes in Korean with this structure:
- Summary (2-3 sentences)
- Key findings (3-5 items, each with an inline citation)
- Open questions (what's unclear or contested)
- References (full list at the bottom)

Save to `~/research/<slug>.md` (slugify topic, ASCII).
Create parent directories if missing. Report the saved path in Korean.
EOF

cat > "$DIR/install.sh" <<'EOF'
#!/usr/bin/env bash
# Install dotfiles-claude into ~/.claude/ via symlinks.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="${HOME}/.claude"
TS="$(date +%Y%m%d-%H%M%S)"
BACKUP_DIR="${TARGET_DIR}/backup-${TS}"

mkdir -p "${TARGET_DIR}/commands"

link_one() {
  local src="$1"
  local dst="$2"
  if [[ -L "$dst" ]]; then
    rm "$dst"
  elif [[ -e "$dst" ]]; then
    mkdir -p "$BACKUP_DIR"
    mv "$dst" "$BACKUP_DIR/"
    echo "backed up: $dst -> $BACKUP_DIR/"
  fi
  ln -s "$src" "$dst"
  echo "linked:    $dst -> $src"
}

link_one "${REPO_DIR}/CLAUDE.md"            "${TARGET_DIR}/CLAUDE.md"
link_one "${REPO_DIR}/settings.json"        "${TARGET_DIR}/settings.json"
link_one "${REPO_DIR}/commands/lesson.md"   "${TARGET_DIR}/commands/lesson.md"
link_one "${REPO_DIR}/commands/research.md" "${TARGET_DIR}/commands/research.md"

echo
echo "Done. Restart Claude Code to pick up changes."
echo "If you backed up an existing settings.json, merge any local-only"
echo "fields into ${TARGET_DIR}/settings.local.json (not tracked)."
EOF
chmod +x "$DIR/install.sh"

cat > "$DIR/.gitignore" <<'EOF'
.credentials.json
settings.local.json
backup-*/
*.swp
.DS_Store
EOF

cat > "$DIR/README.md" <<'EOF'
# Personal Claude Code dotfiles

Synced harness for Claude Code across multiple laptops.

## What's tracked
- `CLAUDE.md` — user-level project memory
- `settings.json` — permissions allowlist (no environment-specific hooks)
- `commands/` — slash commands (`/lesson`, `/research`)
- `install.sh` — symlink installer

## Setup on a new laptop

```bash
git clone <this-repo-url> ~/dotfiles-claude
cd ~/dotfiles-claude
./install.sh
```

## Local-only overrides

Per-machine settings (env-specific hooks, secrets) go in
`~/.claude/settings.local.json`. Claude Code merges it at runtime
and it is not tracked here.

## Updating

```bash
cd ~/dotfiles-claude
# edit files
git add -A && git commit -m "..." && git push
# on the other laptop:
git pull   # symlinks already point in; restart Claude Code
```
EOF

echo "Created $DIR with these files:"
find "$DIR" -type f | sort
echo
echo "Next steps:"
echo "  1. Create an empty private repo on GitHub (e.g. 'dotfiles-claude')"
echo "  2. cd $DIR"
echo "  3. git init -b main && git add -A && git commit -m 'init'"
echo "  4. git remote add origin <your-repo-url>"
echo "  5. git push -u origin main"
echo "  6. ./install.sh"
