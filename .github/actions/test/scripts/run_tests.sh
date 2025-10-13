#!/bin/bash
# Usage: ./run_tests.sh <space delimited list of folders to generate tests for (no leading ./ required)>
# Example: ./run_tests.sh "true" "src app"

COV_ARGS=()
for dir in "$@"; do
  COV_ARGS+=( "--cov=$dir" )
done

if [ -d "tests" ]; then
  source .venv/bin/activate
  COLOR="grey"
  if [ $# -lt 1 ]; then
    echo "Running pytest but not generating any coverage reports"
    COVERAGE="N/A"
    pytest ./tests -v
  else
    echo "Running pytest and generating coverage reports for the following directories: $*"
    pytest "${COV_ARGS[@]}" ./tests -v --cov-report=term --cov-report=html
    COVERAGE=$(coverage report -m | tail -1 | awk '{print $4}' | sed 's/%//')
    echo "COVERAGE: $COVERAGE%"
    
    if (( $(echo "$COVERAGE >= 80" | bc -l) )); then
      COLOR="green"
    elif (( $(echo "$COVERAGE >= 60" | bc -l) )); then
      COLOR="yellow"
    elif (( $(echo "$COVERAGE >= 40" | bc -l) )); then
      COLOR="orange"
    elif (( $(echo "$COVERAGE < 40" | bc -l) )); then
      COLOR="red"
    fi
   
  jq -n --arg score "$COVERAGE%" --arg color "$COLOR" \
  '{
    schemaVersion: 1,
    label: "Test Coverage",
    message: $score,
    color: $color
    }' > coverage_report.json

  fi
else
  echo "No ./tests folder found - no tests will be run"
  exit 0
fi