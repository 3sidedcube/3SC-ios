#!/bin/sh

# An install script for an iOS app.
# This script will install any dependencies required.
#
# Usage: ./install.sh [--skip-dependencies]
#
# Arguments:
# --skip-dependencies: when provided, skip installing dependencies

# Colors for `printf`
CYAN_COLOR='\033[0;36m'
RED_COLOR='\033[0;31m'
NO_COLOR='\033[0m'

# Name of script
SCRIPT_NAME=`basename "$0"`

# Flag which, when found as a command line argument, skips this installation  
SKIP_DEPENDENCIES_FLAG="--skip-dependencies"

# Read script command line arguments
if [[ $* == *${SKIP_DEPENDENCIES_FLAG}* ]]; then
    # Exit script with success
    exit 0
fi

# Homebrew
printf "${CYAN_COLOR}Fetching or updating Homebrew${NO_COLOR}\n"
which -s brew
if [[ $? != 0 ]] ; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    brew update
fi

# Swift Lint
printf "${CYAN_COLOR}Fetching or updating Swift Lint${NO_COLOR}\n"
which -s swiftlint
if [[ $? != 0 ]] ; then
    brew install swiftlint
else
    brew upgrade swiftlint
fi

# Carthage
printf "${CYAN_COLOR}Fetching or updating Carthage${NO_COLOR}\n"
which -s carthage
if [[ $? != 0 ]] ; then
    brew install carthage
else
    brew upgrade carthage
fi

