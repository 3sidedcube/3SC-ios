#!/usr/bin/env bash

#
# Script: sort-xcode-project-file.sh
# Usage: ./sort-xcode-project-file.sh
#
# Description:
# Sorts the Xcode .pbxproj file alphabetically.
#
# Instructions:
# Make sure to check the:
# - Xcode project name is set
# - Perl script is correctly referenced
# - Script correctly references the project
#

# Set defaults
set -o nounset -o errexit -o errtrace -o pipefail

# Xcode project file
XCODE_PROJECT_FILE_NAME=""

# Get directory of script
SCRIPT_DIR="$(cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"

# Script to sort files
SORT_SCRIPT="${SCRIPT_DIR}/reorder-xcode-project-file-alphabetically"

# Path to project file
PROJECT_FILE_PATH="${SCRIPT_DIR}/../${XCODE_PROJECT_FILE_NAME}/project.pbxproj"

# Run the script
"${SORT_SCRIPT}" "${PROJECT_FILE_PATH}"

