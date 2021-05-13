#!/bin/sh

# An install script for an iOS app.
# This script will install any dependencies required.
#
# Usage: ./install.sh [-s]
#
# Arguments:
# -s to skip installing dependencies

# Usage
usage() { echo "Usage: $0 [-s]" 1>&2; exit 1; }

# Colors for `echo`
COLOR='\033[0;36m'
NO_COLOR='\033[0m'

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
    echo "${COLOR}Fetching or updating Homebrew${NO_COLOR}"
    which -s brew
    if [[ $? != 0 ]] ; then
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    else
        brew update
    fi

    # Swift Lint
    echo "${COLOR}Fetching or updating Swift Lint${NO_COLOR}"
    which -s swiftlint
    if [[ $? != 0 ]] ; then
        brew install swiftlint
    else
        brew upgrade swiftlint
    fi

    # Carthage
    echo "${COLOR}Fetching or updating Carthage${NO_COLOR}"
    which -s carthage
    if [[ $? != 0 ]] ; then
        brew install carthage
    else
        brew upgrade carthage
    fi
fi

