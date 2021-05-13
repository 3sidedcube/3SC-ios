#!/bin/sh

# An install script for an iOS app.
# This script will install any dependencies required.
#
# Usage: ./install.sh [-s]
#
# Arguments:
# -s to skip installing dependencies

# Colors for `printf`
CYAN_COLOR='\033[0;36m'
RED_COLOR='\033[0;31m'
NO_COLOR='\033[0m'

# Usage
usage() { printf "${RED_COLOR}Usage: $0 [-s]${NO_COLOR}\n" 1>&2; exit 1; }

# Read script arguments
installDependencies='true'
while getopts ':s' flag; do
  case "${flag}" in
    s) 
        installDependencies='false' 
        ;;
    *) 
        usage
        ;;
  esac
done
shift $((OPTIND-1))

# Install dependencies if flag is set to `true`
if $installDependencies; then
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
fi

