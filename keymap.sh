#!/bin/bash

# Usage:
#
# * Set "si" layout: `keymap.sh si`
# * Set "si_colemak" layout: `keymap.sh si_colemak`
# * Toggle between "si" and "si_colemak" layouts: `keymap.sh`
# * Get current layout: `keymap.sh get`

set -euo pipefail  # https://gist.github.com/maxisam/e39efe89455d26b75999418bf60cf56c

configFolder="${HOME}/.config/keymap"
currKeymapFile="${configFolder}/currKeymap.txt"
# mkdir -p ~/.config/keymap/ && cp keymap.sh ~/.config/keymap/

defaultKeymap="si"
defaultCustomKeymap="si_colemak"

if [ $# -eq 0 ]; then
    # No intput parameter - toggle
    if [ ! -f "${currKeymapFile}" ]; then
        # File doesn't exits -> create it with default keymap
        echo "Current keymap file doesn't exist - creating new one."
        scriptParam="${defaultKeymap}"
    else
        # File exists
        currKeymap=$(cat ${currKeymapFile})
        # echo "Current keymap file content: ${currKeymap}"
        if [ "${currKeymap}" == "${defaultKeymap}" ]; then
            scriptParam="${defaultCustomKeymap}"
        else
            scriptParam="${defaultKeymap}"
        fi
    fi
elif [ "$1" == "get" ]; then
    cat "${currKeymapFile}"
    exit 0
elif [ "$1" != "${defaultCustomKeymap}" ]; then
    scriptParam="${defaultKeymap}"
else
    scriptParam="${defaultCustomKeymap}"
fi

echo "Setting '${scriptParam}'"
echo "${scriptParam}" > "${currKeymapFile}"

# Setup the keymapping
setxkbmap "${scriptParam}"
