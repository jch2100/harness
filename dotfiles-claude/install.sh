#!/usr/bin/env bash
# Install dotfiles-claude into ~/.claude/ via symlinks.
# Idempotent: backs up any existing real files once into ~/.claude/backup-<timestamp>/.
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

link_one "${REPO_DIR}/CLAUDE.md"               "${TARGET_DIR}/CLAUDE.md"
link_one "${REPO_DIR}/settings.json"           "${TARGET_DIR}/settings.json"
link_one "${REPO_DIR}/commands/lesson.md"      "${TARGET_DIR}/commands/lesson.md"
link_one "${REPO_DIR}/commands/research.md"    "${TARGET_DIR}/commands/research.md"

echo
echo "Done. Restart Claude Code to pick up changes."
echo "If you backed up an existing settings.json, merge any local-only fields"
echo "(e.g. environment-specific hooks) into ${TARGET_DIR}/settings.local.json."
