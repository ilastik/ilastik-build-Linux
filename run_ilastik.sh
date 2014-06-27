#!/bin/bash

# we assume that this script resides in BUILDEM_DIR
export BUILDEM_DIR=$(cd `dirname $0` && pwd)

# This script is intended for use within the fully packaged binary.
# Therefore, we want our environment to use ONLY the libraries 
#  included in our own lib directory, not the user's environment
export ILASTIK_USE_CLEAN_LD_LIBRARY_PATH=1
bash $BUILDEM_DIR/bin/ilastik_gui "$@"
