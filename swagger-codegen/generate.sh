#!/usr/bin/env bash

#
# Script: generate.sh
# Usage: ./generate.sh
#
# Generate a Swift package for the generated Swift API files.
#

# Set defaults
set -o nounset -o errexit -o errtrace -o pipefail

# ============================== Configurable Variables ==============================

# Name of the swift package to generate
PACKAGE_NAME="SwiftAPI"

# Open API remote URL
REMOTE_URL="https://developers.strava.com/swagger/swagger.json"

# ============================== Fixed Variables ==============================

# No color
NC='\033[0m'

# Green color
GREEN='\033[0;32m'

# Name of this script
SCRIPT_NAME=`basename "$0"`

# Directory of this script
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Temporary directory to store downloaded files. Deleted on exit.
TMP_DIR="${SCRIPT_DIR}/tmp-${SCRIPT_NAME}"

# Directory of the swift package
PACKAGE_DIR="${SCRIPT_DIR}/${PACKAGE_NAME}"

# Downloaded script to run swagger
SWAGGER_SCRIPT_URL="https://raw.githubusercontent.com/3sidedcube/HTTPRequest/develop/scripts/swagger.sh"

# Name of the swagger script
SWAGGER_SCRIPT="swagger.sh"

# Directory of the generated files
GENERATED_DIR="${TMP_DIR}/SwaggerClient/Classes/Swaggers"

# Package.swift template file
PACKAGE_TEMPLATE_FILE="${SCRIPT_DIR}/Package.swift.template"

# ============================== Functions ==============================

# Print with no color
function print {
    printf "${NC}$@${NC}\n"
}

# Print with green
function printGreen {
    printf "${GREEN}$@${NC}\n"
}

# Clean up temporary files
function cleanup {
    rm -rf ${TMP_DIR}
}

# ============================== Main ==============================

# Clean up on exit
trap cleanup EXIT

# Clean up
cleanup

# Starting
print "Generating '${PACKAGE_NAME}' Swift Package from: '${REMOTE_URL}'"

# Make tmp directory and navigate into it
mkdir ${TMP_DIR}
cd ${TMP_DIR}

# Fetch swagger script
curl -s -H 'Cache-Control: no-cache' "${SWAGGER_SCRIPT_URL}" -o "${SWAGGER_SCRIPT}"

# Generate code in tmp directory
sh ${TMP_DIR}/${SWAGGER_SCRIPT} ${REMOTE_URL} ${TMP_DIR}

# Make swift package file
rm -rf ${PACKAGE_DIR}
mkdir ${PACKAGE_DIR}
cd ${PACKAGE_DIR}

# Make swift package
swift package init

# Remove tests
rm -rf "${PACKAGE_DIR}/Tests"

# Write new Package.swift file
sed -e "s/{PackageName}/${PACKAGE_NAME}/" ${PACKAGE_TEMPLATE_FILE} > "${PACKAGE_DIR}/Package.swift"

# Copy API files into swift package
cp -rf ${GENERATED_DIR}/* "${PACKAGE_DIR}/Sources"

# Clean up with SwiftLint
swiftlint --fix

# Clean up
cleanup

# Move generated code to swift package
printGreen "Success!"

