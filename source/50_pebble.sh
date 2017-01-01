pebble_path=~/pebble-dev/PebbleSDK-current/bin
if [[ -e "$pebble_path" ]]; then
  export PATH=$pebble_path:"$(path_remove $pebble_path)"
fi
