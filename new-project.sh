#!/bin/bash
set -e

# Generic project scaffolder — creates a repo dir + git-inits it. No per-project config and no
# alias injection: zoxide learns the directory the first time you `cd` into it, and `z <name>`
# jumps there afterward. Decoupled by design — this script names no project, so nothing it
# generates can leak. Scaffold docs (README / CLAUDE.md / ROADMAP) with the /bootstrap skill.

NAME="$1"
if [ -z "$NAME" ]; then
  echo "Usage: ./new-project.sh <name>"
  echo "  Creates \$DEV_ROOT/<name> (default ~/dev/<name>) and git-inits it."
  exit 1
fi

ROOT="${DEV_ROOT:-$HOME/dev}"
DIR="$ROOT/$NAME"

if [ -e "$DIR" ]; then
  echo "Error: $DIR already exists"
  exit 1
fi

mkdir -p "$DIR"
git -C "$DIR" init -q

echo "Created $DIR (git initialized)."
echo "Next: cd \"$DIR\"  —  then 'z $NAME' jumps here from anywhere."
echo "Scaffold docs (README / CLAUDE.md / ROADMAP) with the /bootstrap skill."
