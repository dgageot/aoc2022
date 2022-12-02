#!/usr/bin/env bash

set -e

cd "$1" >/dev/null

echo "Expected: $(cat first.rb | awk '/Expected:/ {print $3}')"
echo "     Got: $(ruby first.rb "sample")"
echo

ruby first.rb "input"