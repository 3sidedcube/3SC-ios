#!/usr/bin/env bash

#
# Script: generate.sh
# Usage: ./generate.sh <open-api-json-url> <swift-package-name>
#
# Generate a Swift Package from an OpenAPI URL using Swagger Codegen.
# Configurable variables are provided by user input or command line argument.
# https://github.com/swagger-api/swagger-codegen
#

# Set defaults
set -o nounset -o errexit -o errtrace -o pipefail

# ============================== Variables ==============================

# Red color
RED='\033[0;31m'

# Green color
GREEN='\033[0;32m'

# Yellow color
YELLOW='\033[0;33m'

# No color
NC='\033[0m'

# Name of this script
SCRIPT_NAME=`basename "$0"`

# Directory of this script
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Temporary directory to store downloaded files. Deleted on exit.
TMP_DIR="${SCRIPT_DIR}/tmp-${SCRIPT_NAME}"

# Remote URL where files to perform generation are stored
REMOTE_SRC_URL="https://raw.githubusercontent.com/3sidedcube/3sc-ios/master/swagger-codegen"

# Name of the swagger script
SWAGGER_SCRIPT_NAME="swagger.sh"

# Name of the template Package.swift file
PACKAGE_TEMPLATE_NAME="Package.swift.template"

# Directory of the generated files
GENERATED_DIR="${TMP_DIR}/SwaggerClient/Classes/Swaggers"

# ============================== Functions ==============================

# Print with red
function printRed {
    printf "${RED}$@${NC}\n"
}

# Print with green
function printGreen {
    printf "${GREEN}$@${NC}\n"
}

# Print with yellow
function printYellow {
    printf "${YELLOW}$@${NC}\n"
}

# Print with no color
function print {
    printf "${NC}$@${NC}\n"
}

# Print error message and exit with failure
function fatalError {
    printRed "$1" 1>&2
    exit 1
}

# Prompt the user for input.
# Returns the response string.
function prompt {
    local response
    read -r -p "$(printYellow "$1: ")" response
    echo "${response}"
}

# Check input is not empty
function checkNotEmpty {
    if [ -z "$1" ]; then
        fatalError "Input can not be empty. Exiting..."
    fi
}

# Use curl to download a file the remote source directory
function download {
    curl -H 'Cache-Control: no-cache' "${REMOTE_SRC_URL}/$1" -o "$1"
}

# Clean up temporary files
function cleanup {
    rm -rf ${TMP_DIR}
}

# ============================== Main ==============================

# Remote URL of Open API JSON spec from user input
remoteUrl=""

# Name of the swift package from user input
packageName=""

if [ "$#" -eq 0 ]; then

    # No command line arguments, get input from user prompt
    remoteUrl=$(prompt "Please enter the URL of the OpenAPI JSON to generate from")
    packageName=$(prompt "Please enter the name of the Swift Package to generate")

elif [ "$#" -eq 2 ]; then

    # Get input from command line arguments
    remoteUrl=$1
    packageName=$2

else

    # Invalid number of command line arguments provided
    fatalError "Usage: ./${SCRIPT_NAME} <open-api-json-url> <swift-package-name>"
fi

# Check inputs are non-empty
checkNotEmpty "${remoteUrl}"
checkNotEmpty "${packageName}"

# Directory of the swift package
packageDir="${SCRIPT_DIR}/${packageName}"

# Print start
print "Downloading temporary files for generation..."

# Clean up on exit
trap cleanup EXIT

# Clean up
cleanup

# Make tmp directory and navigate into it
mkdir ${TMP_DIR}
cd ${TMP_DIR}

# Download files used for generation
download "${SWAGGER_SCRIPT_NAME}"
download "${PACKAGE_TEMPLATE_NAME}"

# Print generation
print "Running swagger-codegen..."

# Generate code in tmp directory
sh ${SWAGGER_SCRIPT_NAME} ${remoteUrl} ${TMP_DIR}

# Make swift package file
rm -rf ${packageDir}
mkdir ${packageDir}
cd ${packageDir}

# Make swift package
swift package init

# Remove tests
rm -rf "Tests"

# Write new Package.swift file
sed -e "s/{PackageName}/${packageName}/" ${TMP_DIR}/${PACKAGE_TEMPLATE_NAME} > "Package.swift"

# Copy API files into swift package
cp -rf ${GENERATED_DIR}/* "Sources"

# Clean up with SwiftLint
swiftlint --fix

# Clean up
cleanup

# Print success
printGreen "${packageName} Swift Package successfully generated!"
