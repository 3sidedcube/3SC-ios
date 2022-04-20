#!/usr/bin/env bash

#
# Script: install.sh
# Usage: ./install.sh [--skip-carthage]
# Arguments:
# --skip-carthage: when provided, skip running Carthage
#
# An install script for the iOS app.
# This script will install any dependencies required and perform any additional set up.
#

# Set defaults
set -o nounset -o errexit -o errtrace -o pipefail

# ============================== Constants ==============================

# Get directory path of this script
DIR="$(cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd)"

# Get the project directory
PROJECT_DIRECTORY="${DIR}/.."

# Flag which, when passed as a command line argument, skips running Carthage
SKIP_CARTHAGE_FLAG="--skip-carthage"

# ============================== Main ==============================

# Move to project directory
cd ${PROJECT_DIRECTORY}

# Check if skip carthage flag was provided
if [[ ! $* == *${SKIP_CARTHAGE_FLAG}* ]]; then
    carthage update --use-xcframeworks --platform iOS
fi

