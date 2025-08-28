#!/bin/bash
PYTHON_VER=""

# Parse Python version from .python-version
if [ -f .python-version ]; then
    PYTHON_VER=$(cat .python-version)

# Parse Python version from pyproject.toml - picks the minimum compatible version
elif [ -f pyproject.toml ]; then
    PYTHON_VER=$(
    grep 'requires-python' pyproject.toml \
    | head -1 \
    | awk 'match($0, /[0-9]+\.[0-9]+(\.[0-9]+)?/, m) { print m[0]}'
    )


# Parse Python version from Pipfile
elif [ -f Pipfile ]; then 
    PYTHON_VER=$(
    grep 'python_version' Pipfile \
    | head -1 \
    | awk 'match($0, /[0-9]+\.[0-9]+(\.[0-9]+)?/, m) { print m[0]}'
    )
fi

# Raise error if no version found
if [ -z "$PYTHON_VER" ]; then 
    echo "Error: No Python version detected in .python-version, pyproject.toml, or Pipfile"
    exit 1
fi

echo "Detected Python version:"
echo "$PYTHON_VER"

