#!/bin/bash
#  Show untracked files in the current directory
# 2018 Jan 22 JH Free
echo "The untracked files in the current directory are ..."
git ls-files --other | grep -v /
