#!/bin/bash

SOURCES_LIST=./sources.list
VIMRC=./.vimrc
NVIMINIT=./init.vim

GIT_USER_NAME="wlonestar"
GIT_USER_EMAIL="wlonestar@163.com"

ZSHRC=./.zshrc

function change_source() {
  echo "[setup] change apt source list"
  echo "[setup] backup /etc/apt/sources.list to /etc/apt/sources.list.backup"
  sudo cp /etc/apt/sources.list /etc/apt/sources.list.backup
  sudo cp $SOURCES_LIST /etc/apt/sources.list
  echo "[setup] update and upgrade"
  sudo apt-get update -y
  sudo apt-get upgrade -y
  sudo apt-get autoremove -y
  echo "[setup] finish!"
}

function install_utils() {
  echo "[setup] install essential applications"
  sudo apt-get install vim neovim wget curl net-tools zsh \
    tree baobab python3-pip tmux -y
  echo "[setup] finish!"
}

function config_neovim() {
  echo "[setup] config vim and neovim"
  cp $VIMRC ~/
  mkdir -p ~/.config
  mkdir -p ~/.config/nvim
  cp $NVIMINIT ~/.config/nvim
  echo "[setup] finish!"
}

function config_git() {
  echo "[setup] config global git"
  git config --global credential.helper manager-core
  git config --global user.name $GIT_USER_NAME
  git config --global user.email $GIT_USER_EMAIL
  echo "[setup] finish!"
}

function config_zsh() {
  echo "[setup] config zsh with ohmyzsh"
  git clone git@github.com:ohmyzsh/ohmyzsh.git ~/ohmyzsh
  sh ~/ohmyzsh/tools/install.sh
  echo "[setup] install zsh plugins"
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
  cp $ZSHRC ~/.zshrc
  source ~/.zshrc
  echo "[setup] finish!"
}

function config_c_env() {
  echo "[setup] config c develop environment"
  sudo apt-get install build-essential gdb make cmake clang -y
  echo "[setup] finish!"
}

function config_java_env() {
  echo "[setup] config java develop environment"
  sudo apt-get install openjdk-17-jdk -y
  echo "[setup] finish!"
}

function config_goalng_env() {
  echo "[setup] config golang develop environment"
  sudo apt-get install golang -y
  echo "[setup] finish!"
}

function config_rust_env() {
  echo "[setup] config rust develop environment"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  echo "[setup] finish!"
}

function main() {
  change_source
  install_utils
  config_neovim
  config_git
  config_zsh
  config_c_env
  config_java_env
  config_golang_env
  config_rust_env
}

main

