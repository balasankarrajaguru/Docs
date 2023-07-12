#!/bin/bash
# Demonstrate how read actually works
echo "Starting Git clean"
set -x
git fetch --tags -f
git fetch --prune
git branch -vv | egrep -v "(\[origin\/[a-zA-Z0-9/_-]+\])" | awk "{print \$1}" | xargs git branch -D
set +x
echo "Git clean successful"
