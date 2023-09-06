#!/usr/bin/env bash

#
# Script: set-build-number.sh
# Usage: ./set-build-number.sh [build-number]
#
# Arguments:
# - [build-number]: Build number to set
#
# Description:
# Update build number references in the Xcode project using agvtool including:
# - CFBundleVersions
# - $(CURRENT_PROJECT_VERSION)
#
# Instructions:
# Make sure to check the script correctly references the project.
#

# Set defaults
set -o nounset -o errexit -o errtrace -o pipefail

# ============================== Constants ==============================

# Get directory path of this script
SCRIPT_DIR="$(cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd)"

# Get the project directory
PROJECT_DIRECTORY="${SCRIPT_DIR}/.."

# ============================== Main ==============================

# Check for a build number
if [[ $# -eq 0 ]]; then
    echo 'Please provide a build number as argument' 1>&2
    exit 1
fi

# Move to project directory
cd ${PROJECT_DIRECTORY}

# Run agvtool
xcrun agvtool new-version -all $1