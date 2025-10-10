#!/bin/bash
# Usage: run_tests.sh <space delimited list of folders to generate tests for (no leading ./ required)>
# Example: run_tests.sh "true" "src app"

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