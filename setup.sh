#!/bin/bash

# Exit as soon as anything goes wrong
set -e

# Set the UTILS_DIR for use here and globally
export UTILS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"

# Link the tmux config
[ -e ~/.tmux.conf ] && mv ~/.tmux.conf ~/.tmux.conf.old
ln -s ${UTILS_DIR}/.tmux.conf ~/.tmux.conf

# Link the vimrc
[ -e ~/.vimrc ] && mv ~/.vimrc ~/.vimrc.old
ln -s ${UTILS_DIR}/.vimrc ~/.vimrc

# Provide info to append to .bashrc
echo "Add the following to your .bashrc to import the utils .bashrc:"
echo "export UTILS_DIR=${UTILS_DIR}"
echo "source ${UTILS_DIR}/.bashrc"
