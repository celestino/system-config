#!/bin/bash

if $(confirmModuleInstall "Install vim configuration and modules"); then
    if [ ! -d $_HOME_DIR ] || [ ! -w $_HOME_DIR ]; then
        echo "Directory '${_HOME_DIR}' is not writeable !"
        exit 1
    fi

    cd $_MODULE_DIR
    cp .vimrc  $_HOME_DIR
    cp -R .vim $_HOME_DIR
fi
