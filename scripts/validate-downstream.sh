#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BUILD=false

if [[ "${1:-}" == "--build" ]]; then
  BUILD=true
elif [[ $# -gt 0 ]]; then
  printf 'usage: %s [--build]\n' "$0" >&2
  exit 2
fi

python3 "$ROOT/scripts/documentation_health.py" --check
bash -n "$ROOT/build.sh" "$ROOT/rebrand.sh"

for workflow in "$ROOT"/.github/workflows/*.yml; do
  ruby -e 'require "yaml"; YAML.load_file(ARGV.fetch(0), aliases: true)' "$workflow"
done

if [[ "$BUILD" == true ]]; then
  : "${THEOS:?THEOS must point to a Theos checkout for --build}"
  "$ROOT/build.sh" --rootfull
  compgen -G "$ROOT/packages/*.deb" >/dev/null || {
    printf 'NeoFreeBird build did not produce a package\n' >&2
    exit 1
  }
fi

printf 'NeoFreeBird downstream validation passed\n'
