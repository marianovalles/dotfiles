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
    echo "VALUE OF $1"
    target="${HOME}/${1%.*}"

    if [ -e "${target}" ] && [ ! -L "${target}" ]; then
        echo "mv $target $target.df.bak"
        echo ""
    fi

    echo "ln -sf ${source} .${target}"
    echo ""
}

unlink_file() {
    source="${PWD}/$1"
    target="${HOME}/${1%.*}"

    if [ -e "${target}.df.bak" ] && [ -L "${target}" ]; then
        unlink ${target}
        mv $target.df.bak $target
    fi
}

setup_gitconfig() {
  if ! [ -f git/.gitconfig.symlink ]
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
    "s/GIT_CREDENTIAL_HELPER/$git_credential/g" .gitconfig.example > .gitconfig.symlink

    success 'gitconfig'
  fi
}
# link files in $HOME
setup_dotfiles(){
  if [ "$1" = "restore" ]; then
    for i in `find . -maxdepth 2 -name \*.symlink`
    do
      unlink_file `basename $i`
    done
    exit
  else
    for i in `find . -maxdepth 2 -name \*.symlink`
    do
      link_file `basename $i`
    done
  fi
}

setup_vim_plugins(){
  git submodule update --init --recursive
  git submodule foreach --recursive git pull origin master
  mv .vim .vim.symlink
}

# Boostrap
# setup_gitconfig
setup_vim_plugins
# setup_dotfiles $1


