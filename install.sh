#!/usr/bin/env bash

# Based on:
# https://github.com/sontek/dotfiles
# https://github.com/holman/dotfiles

info () {
  printf "  [ \033[00;34m..\033[0m ] $1"
}

user () {
  printf "\r  [ \033[0;33m?\033[0m ] $1 "
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

link_file() {
    source="${PWD}/$1"
    target="${HOME}/$1"

    if [ -e "${target}" ] && [ ! -L "${target}" ]; then
        mv $target $target.df.bak
    fi

    ln -sf ${source} ${target}
}

unlink_file() {
    source="${PWD}/$1"
    target="${HOME}/$1"

    if [ -e "${target}.df.bak" ] && [ -L "${target}" ]; then
        unlink ${target}
        mv $target.df.bak $target
    fi
}

setup_gitconfig () {
  if ! [ -f git/gitconfig.symlink ]
  then
    info 'setup gitconfig'

    git_credential='cache'
    if [ "$(uname -s)" == "Darwin" ]
    then
      git_credential='osxkeychain'
    fi

    user ' - What is your github author name?'
    read -e git_authorname
    user ' - What is your github author email?'
    read -e git_authoremail

    sed -e "s/AUTHOR_NAME/$git_authorname/g" -e \
    "s/AUTHOR_EMAIL/$git_authoremail/g" -e \
    "s/GIT_CREDENTIAL_HELPER/$git_credential/g" .gitconfig.example

    success 'gitconfig'
  fi
}

setup_gitconfig

#if [ "$1" = "vim" ]; then
#    for i in .vim*
#    do
#       link_file $i
#
#    done
#elif [ "$1" = "restore" ]; then
#    for i in .*
#    do
#        unlink_file $i
#    done
#    exit
#else
#    for i in .*
#    do
#        link_file $i
#    done
#fi
#
#git submodule update --init --recursive
#git submodule foreach --recursive git pull origin master
