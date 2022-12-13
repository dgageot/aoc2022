#!/usr/bin/env bash

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

cd "$1" >/dev/null

expected=$(cat second.rb | awk '/Expected:/ {print $3}')
actual=$(cat sample | ruby second.rb)

if [[ "${expected}" == "${actual}" ]]; then
    printf "Expected: ${expected}\n"
    printf "${GREEN}     Got: ${actual}${NC}\n\n"

    cat "input" | ruby second.rb
else
    printf "Expected: ${expected}\n"
    printf "${RED}     Got: ${actual}${NC}\n"
    exit 1
fi