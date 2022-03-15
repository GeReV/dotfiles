#!/usr/bin/env bash
set -euo pipefail

export SOURCE_DIR={{ .chezmoi.sourceDir }}

source $SOURCE_DIR/source/00_common.sh

e_header "Running '$0'"

for file in ($SOURCE_DIR/scripts/*); do
    e_header "Sourcing $(basename "$file")"
    source "$file"
done