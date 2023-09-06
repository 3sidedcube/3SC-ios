#!/usr/bin/env bash

#
# Script: staging.sh
# Usage: ./staging.sh
# Description: Set to staging environments.
#

# Set defaults
set -o nounset -o errexit -o errtrace -o pipefail

# Get directory path of this script
SCRIPT_DIR="$(cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd)"

# Name of script to set environments
SET_ENVIRONMENTS_SCRIPT_NAME="set-environments.sh"

# Set environments to staging
${SCRIPT_DIR}/${SET_ENVIRONMENTS_SCRIPT_NAME} "staging" "staging-GoogleService-Info.plist"

