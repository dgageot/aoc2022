#!/usr/bin/env bash

set -e

cd "$1" >/dev/null

echo "Expected: $(cat second.rb | awk '/Expected:/ {print $3}')"
echo "     Got: $(ruby second.rb "sample")"
echo

ruby second.rb "input"