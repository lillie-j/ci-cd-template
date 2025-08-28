#!/bin/bash
# Usage: lint_with_pylint.sh <true/false> <comma separated folders to exclude (no leading . & .venv automatically excluded)>
# Example: lint_with_pylint.sh "true" "tests,src"

TRUE_OR_FALSE="$1"
FOLDERS="$2"

source .venv/bin/activate
if [[ "$TRUE_OR_FALSE" == "true" ]]; then
    pylint . --ignore="$FOLDERS,.venv" | tee "pylint.log" || true

elif [[ "$TRUE_OR_FALSE" == "false" ]]; then
    #Exit code of pipeline is last command, - tee should return 0. Need to fail pipeline if pylint does not return 0.
    pylint . --ignore="$FOLDERS,.venv" | tee "pylint.log"
    EXIT_CODE=${PIPESTATUS[0]}

    if [[ $EXIT_CODE -ne 0 ]]; then
    exit $EXIT_CODE
    fi

else
  echo "First positional argument must be 'true' or 'false'"
  exit 1
    
fi

SCORE=$(grep "Your code has been rated at" pylint.log | awk '{print $7}' | cut -d'/' -f1)
COLOR="red"
if (( $(echo "$SCORE >=9" | bc -l) )); then
    COLOR="green"
elif (( $(echo "$SCORE >=7" | bc -l ) )); then
    COLOR="yellow"
elif (( $(echo "$SCORE >=5" | bc -l) )); then
    COLOR="orange"  
elif (( $(echo "$SCORE <5" | bc -l) )); then
    COLOR="red"
fi

python -m pybadges \
--left-text="pylint" \
--right-text="$SCORE" \
--right-color="$COLOR" \
> pylint-badge.svg