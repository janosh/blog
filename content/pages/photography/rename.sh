#!/bin/bash
# make all filenames in directory lowercase and replace spaces with dashes

# file selector, e.g. some/path/* for all files in some/path/
selector=$1

for file in "$selector";
  do mv "$file" `echo $file | tr 'A-Z' 'a-z' | tr ' ' '-'`;
done