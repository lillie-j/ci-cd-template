#!/bin/bash
if [ -d ".venv" ]; then
  exit 0
else
  uv venv
  source .venv/bin/activate
fi

# Parse dependencies from uv.lock
if [ -f "uv.lock" ]; then
    echo "Installing from uv.lock"
    uv sync

# Parse dependencies from requirements.txt  
elif [ -f "requirements.txt" ]; then
    cat <<EOF
No uv.lock file detected. Installing dependencies from requirements.txt.
Recommend creating a uv.lock file. Cache is tied to uv.lock file.
EOF
    uv pip sync requirements.txt


# Parse dependencies from pyproject.toml
elif [ -f "pyproject.toml" ]; then
cat <<EOF
No uv.lock file or requirements.txt detected. Installing dependencies from pyproject.toml.
Recommend creating a uv.lock file to lock exact versions of dependencies.
Cache is tied to uv.lock file. 
EOF
uv pip install -r pyproject.toml

else
echo "Error: No dependency file found - expect one of uv.lock, requirements.txt or pyproject.toml"
exit 1
fi

if [ -f "requirements-ci.txt" ]; then
  uv pip install -r requirements-ci.txt

else
  echo "requirements-ci.txt" not found
  exit 1

fi