#!/bin/sh

# Exit as soon as anything goes wrong
set -e

# Set the UTILS_DIR for use here and globally
export UTILS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"

# Create the todoist virtual environment and install the todoist python module
if ! [ -e ${UTILS_DIR}/todoist-env ] ; then
    virtualenv -p /usr/bin/python2.7 ${UTILS_DIR}/todoist-env
    source ${UTILS_DIR}/todoist-env/bin/activate
    pip install -e ${UTILS_DIR}/todoist-python/
fi

# Link the tmux config
[ -e ~/.tmux.config ] && mv ~/.tmux.config ~/.tmux.config.old
ln -s ${UTILS_DIR}/.tmux.conf ~/.tmux.config 
