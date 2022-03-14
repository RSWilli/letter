#!/bin/bash

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
