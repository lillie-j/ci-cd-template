#!/bin/bash
# Usage: validate_docker_context.sh <build_context>
# Example: validate_docker_context.sh ./src/backend
      
CONTEXT="$1"

if [ ! -d "$CONTEXT" ]; then
  echo "Error: '$CONTEXT' is not a valid directory"
  exit 1
fi

if [ ! -f "$CONTEXT/Dockerfile" ]; then
  echo "Error: No Dockerfile found in '$CONTEXT'"
  exit 1
fi