#!/usr/bin/env bash

#
# Script: test.sh
# Usage: ./test.sh
# Description: Set to test environments.
#

# Set defaults
set -o nounset -o errexit -o errtrace -o pipefail

# Get directory path of this script
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Name of script to set environments
SET_ENVIRONMENTS_SCRIPT_NAME="set-environments.sh"

# Set environments to test
${SCRIPT_DIR}/${SET_ENVIRONMENTS_SCRIPT_NAME} "test" "staging-GoogleService-Info.plist"

