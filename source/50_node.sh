# Alternative version manager to NVM
eval "$(fnm env --use-on-cd)"

# Use npx instead of installing global npm modules
function make_npx_alias () {
  alias $1="npx $@"
}

function get_last_modified_js_file_recursive() {
  find . -type d \( -name node_modules -o -name .git -o -name .build \) -prune -o -type f \( -name '*.js' -o -name '*.jsx' \) -print0 \
    | xargs -0 stat -f '%m %N' \
    | sort -rn \
    | head -1 \
    | cut -d' ' -f2-
}

function watchfile() {
  yarn watch --testPathPattern "$(get_last_modified_js_file_recursive | sed -E 's#.*/([^/]+)/([^.]+).*#\1/\2.#')"
}

function watchdir() {
  yarn watch --testPathPattern "$(dirname "$(get_last_modified_js_file_recursive)")"
}
