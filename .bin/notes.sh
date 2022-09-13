#!/bin/bash -e

# An opinionated script on setting up daily notes to be stored in git

# Required environment variables:
# $NOTE_DIR
# $NOTE_REPO

# Use number parameter to pre-create notes for future days
if [ $# -eq 0 ]; then
  date=$(date +'%m-%d-%Y')
  folder_dir=$(date +"%Y/%m")
else
  folder_dir=$(date --date="$1 day" +"%Y/%m")
  date=$(date --date="$1 day" +'%m-%d-%Y')
fi

# Clone $NOTE_DIR if it doesn't yet exist
if [ ! -d "$NOTE_DIR" ]; then
  git clone "$NOTE_REPO" "$NOTE_DIR"
fi

cd "$NOTE_DIR"

# If git repo is in a clean state, pull any changes
# and create a new branch
if [ -z "$(git status --porcelain)" ]; then
  git pull
  git checkout -b "$date"
fi

mkdir -p "$folder_dir"

cd "$folder_dir"
if [ ! -f "$date.md" ]; then
  echo "# Notes for $date" > "$date.md"
fi

git add .

# Select editor based on what is available
if command -v code &> /dev/null; then
  code "$NOTE_DIR/"
else
  $EDITOR "$NOTE_DIR/"
fi

# vim: ft=bash sw=2 ts=2
