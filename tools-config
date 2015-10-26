#!/bin/bash

_SOURCE_DIR=$(pwd)
_MODULE_DIR=$_SOURCE_DIR
_HOME_DIR=$HOME
_OPTION_ALL_MODULES=0

confirmModuleInstall() {
    if [ $_OPTION_ALL_MODULES == 1 ]; then
        return 0
    fi

    echo -ne "\e[0;32m${*} (y/N)?\e[0m " >&2
     read response
     [[ $response == "y" ]]
}

while [[ $# > 0 ]]; do
    option="$1"
    case $option in
        all|--all)
            _OPTION_ALL_MODULES=1
            ;;
    esac
    shift
done

for installScript in $(find ./*/module.sh); do
    cd $_SOURCE_DIR
    _MODULE_DIR=$(dirname ${installScript})
    source ${installScript}
done
