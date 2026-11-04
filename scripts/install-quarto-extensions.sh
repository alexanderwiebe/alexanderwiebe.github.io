#!/usr/bin/env sh
# Installs the Quarto extensions listed in quarto-extensions.txt into _extensions/, the way
# `npm install` reads package.json. Quarto has no manifest of its own, so this loops `quarto add`.
#
# QUARTO picks the command (default: quarto). For Quarto 2, run `QUARTO=q2 make extensions`.
set -eu
cd "$(dirname "$0")/.."

manifest=quarto-extensions.txt
[ -f "$manifest" ] || { echo "missing $manifest" >&2; exit 1; }

QUARTO="${QUARTO:-quarto}"
# Major version from output like "1.11.9" or "q2 0.40.0-nightly.20261104".
version="$("$QUARTO" --version | grep -o '[0-9][0-9]*\.[0-9][0-9]*' | head -n 1 | cut -d. -f1)"
[ -n "$version" ] || { echo "could not read the version from '$QUARTO --version'" >&2; exit 1; }

# Quarto 2 (versions 0.x) refuses remote extensions without a prompt unless --trust is passed.
# Quarto 1's `quarto add` has no --trust option, so it is passed only to Quarto 2.
trust=""
[ "$version" -lt 1 ] && trust="--trust"

sed -e 's/#.*//' -e 's/[[:space:]]*$//' -e '/^$/d' "$manifest" | while read -r source; do
  echo "$QUARTO add $source --no-prompt $trust"
  "$QUARTO" add "$source" --no-prompt $trust
done
