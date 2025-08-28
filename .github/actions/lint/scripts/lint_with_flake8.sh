#!/bin/bash
# Usage: lint_with_flake8.sh <true/false> <comma separated folders to exclude (no leading . & .venv automatically excluded)>
# Example: lint_with_flake8.sh "true" "src,tests"

TRUE_OR_FALSE="$1"
FOLDERS="$2"

source .venv/bin/activate
if [[ "$TRUE_OR_FALSE" == "true" ]]; then
    flake8 . --exclude="$FOLDERS,.venv" --exit-zero

elif [[ "$TRUE_OR_FALSE" == "false" ]]; then
    flake8 . --exclude="$FOLDERS,.venv"

else
  echo "First positional argument must be 'true' or 'false'"
  exit 1

fi