#!/usr/bin/env bash
# Install dotfiles into ~/.claude/ and ~/.codex/ via symlinks.
# Idempotent: any existing real files are backed up once.
#
# Usage:
#   ./install.sh           # install for both tools (default)
#   ./install.sh claude    # install for Claude Code only
#   ./install.sh codex     # install for Codex CLI only
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TS="$(date +%Y%m%d-%H%M%S)"

link_one() {
  local src="$1"
  local dst="$2"
  local backup_dir
  backup_dir="$(dirname "$dst")/backup-${TS}"
  if [[ ! -e "$src" ]]; then
    echo "skip:      $src does not exist"
    return
  fi
  if [[ -L "$dst" ]]; then
    rm "$dst"
  elif [[ -e "$dst" ]]; then
    mkdir -p "$backup_dir"
    mv "$dst" "$backup_dir/"
    echo "backed up: $dst -> $backup_dir/"
  fi
  mkdir -p "$(dirname "$dst")"
  ln -s "$src" "$dst"
  echo "linked:    $dst -> $src"
}

install_claude() {
  local target="${HOME}/.claude"
  link_one "${REPO_DIR}/shared/profile.md"             "${target}/CLAUDE.md"
  link_one "${REPO_DIR}/claude/settings.json"          "${target}/settings.json"
  link_one "${REPO_DIR}/claude/commands/lesson.md"     "${target}/commands/lesson.md"
  link_one "${REPO_DIR}/claude/commands/research.md"   "${target}/commands/research.md"
}

install_codex() {
  local target="${HOME}/.codex"
  link_one "${REPO_DIR}/shared/profile.md"             "${target}/AGENTS.md"
  link_one "${REPO_DIR}/codex/config.toml"             "${target}/config.toml"
  link_one "${REPO_DIR}/codex/prompts/lesson.md"       "${target}/prompts/lesson.md"
  link_one "${REPO_DIR}/codex/prompts/research.md"     "${target}/prompts/research.md"
}

case "${1:-both}" in
  claude) install_claude ;;
  codex)  install_codex ;;
  both)   install_claude; install_codex ;;
  *)      echo "Usage: $0 [claude|codex|both]" >&2; exit 1 ;;
esac

echo
echo "Done. Restart your CLI(s) to pick up changes."
echo "Local-only overrides (machine-specific hooks, secrets):"
echo "  Claude: ~/.claude/settings.local.json"
echo "  Codex:  ~/.codex/config.local.toml"
