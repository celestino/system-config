#!/bin/bash

if $(confirmModuleInstall "Install zsh configuration"); then
    if [ ! -d $_HOME_DIR ] || [ ! -w $_HOME_DIR ]; then
        echo "Directory '${_HOME_DIR}' is not writeable !"
        exit 1
    fi

    cd $_MODULE_DIR
    cp .zshrc \
        .zsh-command-coloring \
        .zsh-git-completition \
        .dircolors \
        .aliases \
        $_HOME_DIR
fi
