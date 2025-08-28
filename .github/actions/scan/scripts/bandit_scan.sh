#!/bin/bash
# Usage: bandit_scan.sh <comma separated list of folders to exclude (leading . required and ./.venv automatically excluded)> 
# Example: bandit_scan.sh "./tests,."

INPUT="$1"
source .venv/bin/activate
# Always exclude ./.venv
venv_str="./.venv"
folders_to_exclude="$INPUT,$venv_str"
# Separate commands needed to output to console & html; scan set to always pass
bandit -r . -x "$folders_to_exclude" -f screen || true 
bandit -r . -x "$folders_to_exclude" -f html -o bandit_report.html || true