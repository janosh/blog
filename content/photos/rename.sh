#!/bin/bash
# make all filenames in matching pattern passed as first argument
# to script lowercase and replace spaces with dashes

# file selector, e.g. some/path/* for all files in some/path/
selector=${1:-photos}

exiftool '-filename<${Headline}.jpg' -r "$selector"

# change file names to param case (this-is-param-case.ext)
rename -c -S ' ' '-' "$selector"/*