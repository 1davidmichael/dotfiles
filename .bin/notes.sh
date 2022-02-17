#!/bin/bash -e

if [ $# -eq 0 ]; then
	folder_dir=$(date +"%Y/%m")
	date=$(date +'%m-%d-%Y')
else
	day=$1
	folder_dir=$(date --date="$1 day" +"%Y/%m")
	date=$(date --date="$1 day" +'%m-%d-%Y')
fi

if [ ! -f $NOTED_DIR ]; then
	git clone git@github.com:1davidmichael/Notes.git $NOTED_DIR
fi

# An opinionated script on setting up daily notes to be stored in git
cd $NOTE_DIR
mkdir -p "$folder_dir"

cd "$folder_dir"
if [ ! -f "$date.md" ]; then
	echo "# Notes for $date" > "$date.md"
fi

git add .
if command -v code &> /dev/null; then
	code $NOTE_DIR/
else
	vim $NOTE_DIR/
fi
