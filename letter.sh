#!/bin/bash

pandoc "$1" -s -o "$1.pdf" --template="./letter-template.tex"
