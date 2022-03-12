# Logging stuff.
function e_header()   { echo -e "\n\033[1m$@\033[0m"; }
function e_success()  { echo -e " \033[1;32m✔\033[0m  $@"; }
function e_error()    { echo -e " \033[1;31m✖\033[0m  $@"; }
function e_arrow()    { echo -e " \033[1;34m➜\033[0m  $@"; }

# OS detection
function is_osx() {
  [[ "$OSTYPE" =~ ^darwin ]] || return 1
}
function is_ubuntu() {
  [[ "$(cat /etc/issue 2> /dev/null)" =~ 'Ubuntu|Raspbian' ]] || return 1
}
function is_ubuntu_desktop() {
  dpkg -l ubuntu-desktop >/dev/null 2>&1 || return 1
}
function get_os() {
  for os in osx ubuntu ubuntu_desktop; do
    is_$os; [[ $? == ${1:-0} ]] && echo $os
  done
}

# Remove an entry from $PATH
# Based on http://stackoverflow.com/a/2108540/142339
function path_remove() {
  local arg p
  p=":$PATH:"
  for arg in "$@"; do path="${p/:$arg:/:}"; done
  p="${p%:}"
  p="${p#:}"
  echo "$p"
}

# Given strings containing space-delimited words A and B, "setdiff A B" will
# return all words in A that do not exist in B. Arrays in bash are insane
# (and not in a good way).
# From http://stackoverflow.com/a/1617303/142339
function setdiff() {
  local debug skip a b
  if [[ "$1" == 1 ]]; then debug=1; shift; fi
  if [[ "$1" ]]; then
    local setdiff_new setdiff_cur setdiff_out
    setdiff_new=($1); setdiff_cur=($2)
  fi
  setdiff_out=()
  for a in "${setdiff_new[@]}"; do
    skip=
    for b in "${setdiff_cur[@]}"; do
      [[ "$a" == "$b" ]] && skip=1 && break
    done
    [[ "$skip" ]] || setdiff_out=("${setdiff_out[@]}" "$a")
  done
  [[ "$debug" ]] && for a in setdiff_new setdiff_cur setdiff_out; do
    echo "$a ($(eval echo "\${#$a[*]}")) $(eval echo "\${$a[*]}")" 1>&2
  done
  [[ "$1" ]] && echo "${setdiff_out[@]}"
}

# Array mapper. Calls map_fn for each item ($1) and index ($2) in array, and
# prints whatever map_fn prints. If map_fn is omitted, all input array items
# are printed.
# Usage: array_map array_name [map_fn]
function array_map() {
  local __i__ __val__ __arr__=$1; shift
  for __i__ in $(eval echo "\${!$__arr__[@]}"); do
    __val__="$(eval echo "\"\${$__arr__[__i__]}\"")"
    if [[ "$1" ]]; then
      "$@" "$__val__" $__i__
    else
      echo "$__val__"
    fi
  done
}

# Print bash array in the format "i <val>" (one per line) for debugging.
function array_print() { array_map $1 __array_print; }
function __array_print() { echo "$2 <$1>"; }

# Array filter. Calls filter_fn for each item ($1) and index ($2) in array_name
# array, and prints all values for which filter_fn returns a non-zero exit code
# to stdout. If filter_fn is omitted, input array items that are empty strings
# will be removed.
# Usage: array_filter array_name [filter_fn]
# Eg. mapfile filtered_arr < <(array_filter source_arr)
function array_filter() { __array_filter 1 "$@"; }
# Works like array_filter, but outputs array indices instead of array items.
function array_filter_i() { __array_filter 0 "$@"; }
# The core function. Wheeeee.
function __array_filter() {
  local __i__ __val__ __mode__ __arr__
  __mode__=$1; shift; __arr__=$1; shift
  for __i__ in $(eval echo "\${!$__arr__[@]}"); do
    __val__="$(eval echo "\${$__arr__[__i__]}")"
    if [[ "$1" ]]; then
      "$@" "$__val__" $__i__ >/dev/null
    else
      [[ "$__val__" ]]
    fi
    if [[ "$?" == 0 ]]; then
      if [[ $__mode__ == 1 ]]; then
        eval echo "\"\${$__arr__[__i__]}\""
      else
        echo $__i__
      fi
    fi
  done
}

# Array join. Joins array ($1) items on string ($2).
function array_join() { __array_join 1 "$@"; }
# Works like array_join, but removes empty items first.
function array_join_filter() { __array_join 0 "$@"; }

function __array_join() {
  local __i__ __val__ __out__ __init__ __mode__ __arr__
  __mode__=$1; shift; __arr__=$1; shift
  for __i__ in $(eval echo "\${!$__arr__[@]}"); do
    __val__="$(eval echo "\"\${$__arr__[__i__]}\"")"
    if [[ $__mode__ == 1 || "$__val__" ]]; then
      [[ "$__init__" ]] && __out__="$__out__$@"
      __out__="$__out__$__val__"
      __init__=1
    fi
  done
  [[ "$__out__" ]] && echo "$__out__"
