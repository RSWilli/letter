#!/bin/bash

pandoc "$1" -s -o letter.pdf --template="./letter-template.tex"
