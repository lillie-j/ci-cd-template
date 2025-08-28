#!/bin/bash
if [ -d "tests" ]; then
  source .venv/bin/activate
  pytest --cov=src ./tests -v --cov-report=html
else
  echo "No ./tests folder found - no tests will be run"
  exit 0
fi