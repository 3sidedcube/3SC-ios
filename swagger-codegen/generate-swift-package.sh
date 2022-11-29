#!/usr/bin/env bash

#
# Script: generate-swift-package.sh
# Usage: ./generate-swift-package.sh
#
# Downloads and runs generate.sh passing in configuration as command line arguments.
#

# Set defaults
set -o nounset -o errexit -o errtrace -o pipefail

# ============================== Configurable Variables ==============================

# Remote URL of OpenAPI URL
REMOTE_URL="https://developers.strava.com/swagger/swagger.json"

# Name of the swift package to generate
PACKAGE_NAME="StravaAPI"

# ============================== Script ==============================

# Tmp local script of remote generate script
TMP_SCRIPT="tmp-generate.sh"

# Remote script URL where files to perform generation are stored
REMOTE_SCRIPT_URL="https://raw.githubusercontent.com/3sidedcube/3sc-ios/master/swagger-codegen/generate.sh"

# Clean up temporary files
function cleanup {
    rm -rf "${TMP_SCRIPT}"
}

# Clean up on exit
trap cleanup EXIT

# Clean up
cleanup

# Download script and run passing command line arguments
curl -H 'Cache-Control: no-cache' "${REMOTE_SCRIPT_URL}" -o "${TMP_SCRIPT}"

# Run generate script
sh "${TMP_SCRIPT}" ${REMOTE_URL} ${PACKAGE_NAME}

# Clean up
cleanup
