#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <file>" >&2
    exit 1
fi

if [ ! -f "$1" ]; then
    echo "File $1 does not exist" >&2
    exit 2
fi

function cleanup() {
    exit 0
}

trap cleanup EXIT

while true; do
    echo "compiling $1"
    pandoc "$1" -s -o "$1.pdf" --template="./letter-template.tex"
    echo "watching $1 for changes"
    inotifywait -qre close_write "$1"
done
