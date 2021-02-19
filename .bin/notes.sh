#!/bin/bash

# An opinionated script on setting up daily notes to be stored in git
cd $NOTE_DIR
mkdir -p $(date +"%Y/%m")

cd $(date +"%Y/%m")
if [ ! -f "$(date +'%m-%d-%Y').md" ]; then
	    echo "# Notes for $(date +'%m/%d/%Y')" > "$(date +'%m-%d-%Y').md"
fi

git add .
code $NOTE_DIR/
