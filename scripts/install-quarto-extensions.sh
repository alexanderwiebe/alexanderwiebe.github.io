#!/usr/bin/env sh
# Installs the Quarto extensions listed in quarto-extensions.txt into _extensions/, the way
# `npm install` reads package.json. Quarto has no manifest of its own, so this loops `quarto add`.
set -eu
cd "$(dirname "$0")/.."

manifest=quarto-extensions.txt
[ -f "$manifest" ] || { echo "missing $manifest" >&2; exit 1; }

sed -e 's/#.*//' -e 's/[[:space:]]*$//' -e '/^$/d' "$manifest" | while read -r source; do
  echo "quarto add $source"
  quarto add "$source" --no-prompt
done
