#!/bin/bash

if $(confirmModuleInstall "Install terminator configuration"); then
    if [ ! -d $_HOME_DIR ] || [ ! -w $_HOME_DIR ]; then
        echo "Directory '${_HOME_DIR}' is not writeable !"
        exit 1
    fi

    _TERM_CONFIG_DIR="${_HOME_DIR}/.config/terminator"
    _TERM_CONFIG_FILE="${_TERM_CONFIG_DIR}/config"

    mkdir -p $_TERM_CONFIG_DIR
    cd $_MODULE_DIR
    cp config  $_TERM_CONFIG_FILE
fi
