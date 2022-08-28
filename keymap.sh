#!/bin/bash

# Usage:
#
# * Set "si" layout: `keymap.sh si`
# * Set "si_colemak" layout: `keymap.sh si_colemak`
# * Toggle between "si" and "si_colemak" layouts: `keymap.sh`
# * Get current layout: `keymap.sh get`

set -euo pipefail  # https://gist.github.com/maxisam/e39efe89455d26b75999418bf60cf56c

# configFolder="${HOME}/.config/keymap"
# mkdir -p ~/.config/keymap/ && cp keymap.sh ~/.config/keymap/

defaultKeymap="si"
defaultCustomKeymap="si_colemak"

if [ $# -eq 0 ]; then
    # No intput parameter - toggle
    currKeymap=$(setxkbmap -query | awk '/layout/ {split($0,a," "); print a[2]}')
    # echo "Current keymap file content: ${currKeymap}"
    if [ "${currKeymap}" == "${defaultKeymap}" ]; then
        scriptParam="${defaultCustomKeymap}"
    else
        scriptParam="${defaultKeymap}"
    fi
elif [ "$1" == "get" ]; then
    currKeymap=$(setxkbmap -query | awk '/layout/ {split($0,a," "); print a[2]}')
    echo "$currKeymap"
    exit 0
elif [ "$1" != "${defaultCustomKeymap}" ]; then
    scriptParam="${defaultKeymap}"
else
    scriptParam="${defaultCustomKeymap}"
fi

echo "Setting '${scriptParam}'"

# Setup the keymapping
setxkbmap "${scriptParam}"
