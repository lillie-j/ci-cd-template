#!/bin/bash
# Usage: ./check_membership.sh <item> <list>
# Example: ./check_membership.sh "uv" "uv pipenv venv"

INPUT="$1"
LIST="$2"

for i in $LIST; do
  if [[ "$i" == "$INPUT" ]]; then
    echo "$INPUT is a valid input"
    exit 0
  fi
done

echo "$INPUT is not a valid input. Valid inputs are: $LIST"
exit 1