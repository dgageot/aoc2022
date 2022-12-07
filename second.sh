#!/usr/bin/env bash

set -e

cd "$1" >/dev/null

echo "Expected: $(cat second.rb | awk '/Expected:/ {print $3}')"
echo "     Got: $(cat "sample" | ruby second.rb)"
echo

cat "input" | ruby second.rb