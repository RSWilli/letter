#!/bin/bash

# watch a .md file and compile it to a pdf using pandoc using a template
#  - requires inotify-tools
#  - requires pandoc
# watches both the .md file and the template for changes

if [ $# -ne 2 ]; then
    echo "Usage: $0 <file> <template>" >&2
    exit 1
fi

if [ ! -f "$1" ]; then
    echo "File $1 does not exist" >&2
    exit 2
fi

if [ ! -f "$2" ]; then
    echo "File $2 does not exist" >&2
    exit 2
fi

function cleanup() {
    exit 0
}

trap cleanup EXIT

while true; do
    echo "compiling $1"
    pandoc "$1" -s -o "$1.pdf" --template="$2"
    echo "watching $1 and $2 for changes"
    inotifywait -qre close_write "$1" "$2"
done
