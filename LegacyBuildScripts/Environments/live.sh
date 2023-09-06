#!/usr/bin/env bash

#
# Script: live.sh
# Usage: ./live.sh
# Description: Set to live environments.
#

# Set defaults
set -o nounset -o errexit -o errtrace -o pipefail

# Get directory path of this script
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Name of script to set environments
SET_ENVIRONMENTS_SCRIPT_NAME="set-environments.sh"

# Set environments to live
${SCRIPT_DIR}/${SET_ENVIRONMENTS_SCRIPT_NAME} "live" "live-GoogleService-Info.plist"

