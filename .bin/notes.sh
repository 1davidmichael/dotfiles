#!/usr/bin/env bash
set -euo pipefail

# An opinionated script for managing daily notes stored in git.
#
# Required environment variables:
#   NOTE_DIR   - local path where the notes repo lives (or will be cloned)
#   NOTE_REPO  - remote git URL to clone if NOTE_DIR does not exist

usage() {
  cat <<EOF
Usage: notes [SUBCOMMAND] [ARG]

Subcommands:
  open [DAYS]    Open (or create) notes for today or DAYS days in the future.
                 DAYS must be a non-negative integer (default: 0).
  commit [DAYS]  Stage and commit the day's notes with message:
                   "Add notes for MM/DD/YYYY"
                 DAYS must be a non-negative integer (default: 0).
  merge          Create a PR for the current branch and merge it:
                   gh pr create -f && gh pr merge -d -r
  help, -h       Show this help message.

Environment variables:
  NOTE_DIR       Local directory for the notes repo.
  NOTE_REPO      Remote git URL (used when NOTE_DIR does not exist).
EOF
}

check_env() {
  local missing=0
  if [[ -z "${NOTE_DIR:-}" ]]; then
    echo "error: NOTE_DIR is not set" >&2
    missing=1
  fi
  if [[ -z "${NOTE_REPO:-}" ]]; then
    echo "error: NOTE_REPO is not set" >&2
    missing=1
  fi
  (( missing == 0 ))
}

cmd_open() {
  local days="${1:-0}"

  if ! [[ "$days" =~ ^[0-9]+$ ]]; then
    echo "error: DAYS must be a non-negative integer, got: '$days'" >&2
    return 1
  fi

  check_env

  local date folder_dir
  if (( days == 0 )); then
    date=$(date +'%m-%d-%Y')
    folder_dir=$(date +"%Y/%m")
  else
    date=$(date -v +"${days}"d +'%m-%d-%Y')
    folder_dir=$(date -v +"${days}"d +"%Y/%m")
  fi

  if [[ ! -d "$NOTE_DIR" ]]; then
    git clone "$NOTE_REPO" "$NOTE_DIR"
  fi

  cd "$NOTE_DIR"

  if [[ -z "$(git status --porcelain)" ]]; then
    git pull
    git checkout -b "$date"
  fi

  mkdir -p "$folder_dir"

  local note_file="${folder_dir}/${date}.md"
  if [[ ! -f "$note_file" ]]; then
    echo "# Notes for $date" > "$note_file"
  fi

  git add .
}

cmd_commit() {
  local days="${1:-0}"

  if ! [[ "$days" =~ ^[0-9]+$ ]]; then
    echo "error: DAYS must be a non-negative integer, got: '$days'" >&2
    return 1
  fi

  check_env
  cd "$NOTE_DIR"

  local date_slug folder_dir commit_date
  if (( days == 0 )); then
    date_slug=$(date +'%m-%d-%Y')
    folder_dir=$(date +"%Y/%m")
    commit_date=$(date +'%m/%d/%Y')
  else
    date_slug=$(date -v +"${days}"d +'%m-%d-%Y')
    folder_dir=$(date -v +"${days}"d +"%Y/%m")
    commit_date=$(date -v +"${days}"d +'%m/%d/%Y')
  fi

  local note_file="${folder_dir}/${date_slug}.md"
  git add "$note_file"
  git commit -m "Add notes for ${commit_date}"
}

cmd_merge() {
  check_env
  cd "$NOTE_DIR"
  gh pr create -f && gh pr merge -d -r
}

main() {
  local subcommand="${1:-open}"

  case "$subcommand" in
    open)
      shift
      cmd_open "${1:-0}"
      ;;
    commit)
      shift
      cmd_commit "${1:-0}"
      ;;
    merge)
      cmd_merge
      ;;
    help|-h|--help)
      usage
      ;;
    *)
      echo "error: unknown subcommand '$subcommand'" >&2
      echo >&2
      usage >&2
      return 1
      ;;
  esac
}

main "$@"

# vim: ft=bash sw=2 ts=2
