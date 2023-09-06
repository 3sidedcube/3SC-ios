#!/usr/bin/env bash

#
# Script: generate-swift-package.sh
# Usage: ./generate-swift-package.sh
#
# Description:
# Downloads and runs generate.sh passing in configuration as command line arguments.
#

# Set defaults
set -o nounset -o errexit -o errtrace -o pipefail

# Script directory (use for relative path to ${SWIFT_PACKAGE_PATH})
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Branch of 3SC-iOS
BRANCH="develop"

# ============================== Configurable Variables ==============================

# Remote URL of OpenAPI URL
REMOTE_URL="<open-api-json-url>"

# Path to the source code files of the Swift package
SWIFT_PACKAGE_PATH="<swift-package-src-path>"

# ============================== Script ==============================

# Tmp local script of remote generate script
TMP_SCRIPT="tmp-generate.sh"

# Remote script URL where files to perform generation are stored
REMOTE_SCRIPT_URL="https://raw.githubusercontent.com/3sidedcube/3sc-ios/${BRANCH}/SwaggerCodegen/generate.sh"

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
sh "${TMP_SCRIPT}" "${REMOTE_URL}" "${SWIFT_PACKAGE_PATH}"

# Clean up
cleanup

