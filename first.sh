#!/usr/bin/env bash

set -e

cd "$1" >/dev/null

echo "Expected: $(cat first.rb | awk '/Expected:/ {print $3}')"
echo "     Got: $(cat "sample" | ruby first.rb)"
echo

cat "input" | ruby first.rb