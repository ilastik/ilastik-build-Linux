#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 directory"
    exit 1
fi

# we assume that this script resides in BUILDEM_DIR/bin
export BUILDEM_DIR=$(cd `dirname $0`/.. && pwd)
source $BUILDEM_DIR/bin/setenv_ilastik_gui.sh

find "$1" -name "*.so" -exec ldd {} \; | awk '/not found/ { print; } !/not found/ {if ($4 != "") { system("cd $(dirname " $3") && echo $PWD/$(basename " $3 ")"); } }' | sort -u
