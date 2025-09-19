#!/bin/bash
# Exit immediately if command fails, undefined variables = fail, cause entire pipeline to fail
set -euo pipefail

COV_ARGS=()
for dir in "$@"; do
  COV_ARGS+=( "--cov=$dir" )
done

if [ -d "tests" ]; then
  source .venv/bin/activate
  if [ $# -lt 1 ]; then
    echo "Running pytest but not generating any coverage reports"
    pytest ./tests -v
  else
    echo "Running pytest and generating coverage reports for the following directories: $*"
    pytest "${COV_ARGS[@]}" ./tests -v --cov-report=term --cov-report=html
  fi
else
  echo "No ./tests folder found - no tests will be run"
  exit 0
fi