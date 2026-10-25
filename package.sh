#!/bin/sh
# Build a platform-independent Gemini CLI release archive.
# gemini-extension.json is at the archive root (gallery and GitHub Release layout).
set -eu
cd "$(dirname "$0")"
mkdir -p dist
COPYFILE_DISABLE=1 tar -czf dist/hail.tar.gz \
  gemini-extension.json \
  GEMINI.md \
  commands \
  skills
echo "dist/hail.tar.gz"
