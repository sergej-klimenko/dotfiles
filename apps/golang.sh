#!/bin/zsh

###############################################################################
# Golang
###############################################################################

mode=$1

if [ "$mode" = "remote" ]; then
  return 0
fi

echo "Golang ($mode)"

# goenv *should* be installed at this point
hash goenv 2>/dev/null || echo "Please install goenv before continuing"

# Install latest (stable) Golang
golang_latest=$(goenv install -l 2>/dev/null | awk '$1 ~ /^[0-9.]*$/ {latest=$1} END {print latest}')
goenv install --skip-existing $golang_latest
goenv rehash
goenv global $golang_latest