#!/bin/bash

if $(confirmModuleInstall "Install git configuration"); then
    if [ ! -d $_HOME_DIR ] || [ ! -w $_HOME_DIR ]; then
        echo "Directory '${_HOME_DIR}' is not writeable !"
        exit 1
    fi

    _GIT_CONFIG_DIR="${_HOME_DIR}/.config/git"
    _GIT_CONFIG_FILE="${_GIT_CONFIG_DIR}/config"
    _GIT_EXCLUDE_FILE="${_GIT_CONFIG_DIR}/exclude"

    mkdir -p $_GIT_CONFIG_DIR
    cd $_MODULE_DIR
    cp config  $_GIT_CONFIG_FILE
    cp exclude $_GIT_EXCLUDE_FILE
    sed -i -e "s/@EXCLUDE_FILE@/$(echo $_GIT_EXCLUDE_FILE | sed -e 's/\\/\\\\/g' -e 's/\//\\\//g' -e 's/&/\\\&/g')/g" \
        $_GIT_CONFIG_FILE
fi
