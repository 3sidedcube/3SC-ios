#!/usr/bin/env bash

#
# Script: generate.sh
# Usage: ./generate.sh
#
# Runs generate-from-input.sh answering the interactive prompts from
# fixed constants defined in this script.
#

# Set defaults
set -o nounset -o errexit -o errtrace -o pipefail

# ============================== Configurable Variables ==============================

# Remote URL of OpenAPI URL
REMOTE_URL="https://developers.strava.com/swagger/swagger.json"

# Name of the swift package to generate
PACKAGE_NAME="SwiftAPI"

# ============================== Fixed Variables ==============================

# Remote script URL where files to perform generation are stored
REMOTE_SCRIPT="https://raw.githubusercontent.com/3sidedcube/3sc-ios/master/swagger-codegen/generate-from-input.sh"

# ============================== Main ==============================

# Download script and run passing command line arguments
curl -Ls ${REMOTE_SCRIPT} | bash -s -- ${REMOTE_URL} ${PACKAGE_NAME}
