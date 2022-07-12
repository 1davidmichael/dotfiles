#!/bin/bash -e

# An opinionated script on setting up daily notes to be stored in git

# Required environment variables:
# $NOTED_DIR
# $NOTE_REPO

# Use number parameter to pre-create notes for future days
if [ $# -eq 0 ]; then
  older_dir=$(date +"%Y/%m")
  date=$(date +'%m-%d-%Y')
  folder_dir=$(date +"%Y/%m")
else
  day=$1
  folder_dir=$(date --date="$1 day" +"%Y/%m")
  date=$(date --date="$1 day" +'%m-%d-%Y')
fi

# Clone $NOTE_DIR if it doesn't yet exist
if [ ! -f $NOTED_DIR ]; then
  git clone "$NOTE_REPO" "$NOTED_DIR"
fi

cd $NOTE_DIR
if [ -z "$(git status --porcelain)" ]; then
  git pull
fi

mkdir -p "$folder_dir"

cd "$folder_dir"
if [ ! -f "$date.md" ]; then
  echo "# Notes for $date" > "$date.md"
fi

git add .
if command -v code &> /dev/null; then
  code $NOTE_DIR/
elif command -v nvim &> /dev/null; then
  nvim $NOTE_DIR/
else
  vim $NOTE_DIR/
fi

# vim: ft=bash sw=2 ts=2
