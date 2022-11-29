#!/usr/bin/env bash

#
# Script: 
# generate.sh
# 
# Usage: 
# ./generate.sh <open-api-json-url> <swift-package-src-path>
#
# Description:
# Generate Swift code from an OpenAPI URL using Swagger Codegen.
# Configurable variables are provided by command line argument or user input.
# If command line arguments are omitted, then the script will prompt for input.
#
# Warning:
# Running this script may overwrite files in the swift package.
#
# Resources:
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

# Command of swagger-codegen
SWAGGER_CODEGEN_COMMAND="swagger-codegen"

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
    read -e -p "$(printYellow "$1")" response
    echo "${response}"
}

# Check input is not empty
function checkNotEmpty {
    if [ -z "$1" ]; then
        fatalError "Input can not be empty. Exiting..."
    fi
}

# ============================== Main ==============================

# Check swagger-codegen is installed
if ! [ -x "$(command -v ${SWAGGER_CODEGEN_COMMAND})" ]; then
    fatalError "Please install ${SWAGGER_CODEGEN_COMMAND}."
fi

# Remote URL of Open API JSON spec
remoteUrl=""

# Path to the source directory of the swift package
swiftPackagePath=""

if [ "$#" -eq 0 ]; then

    # No command line arguments, get input from user prompt
    remoteUrl=$(prompt "Please enter the URL of the OpenAPI JSON to generate from: ")
    checkNotEmpty "${remoteUrl}"
    
    swiftPackagePath=$(prompt "Please enter the path of the Swift Package: ")
    checkNotEmpty "${swiftPackagePath}"

elif [ "$#" -eq 2 ]; then

    # Get input from command line arguments
    remoteUrl=$1
    swiftPackagePath=$2

else

    # Invalid number of command line arguments provided
    fatalError "Usage: $0 <open-api-json-url> <swift-package-path>"
fi

# Expand tilde using Bash parameter expansion
swiftPackagePath="${swiftPackagePath/#\~/$HOME}"

# Remove single trailing slash if required
swiftPackagePath=${swiftPackagePath%/}

# Check swift package directory exists
if [ ! -d "${swiftPackagePath}" ]; then
    fatalError "Swift package path: '${swiftPackagePath}' does not exist."
fi

# Move to swift package directory
cd ${swiftPackagePath}

# Temporary directory to store generated files. Deleted on exit.
tmpDir="${swiftPackagePath}/tmp-swagger-codegen"

# Clean up temporary files
function cleanup {
    rm -rf ${tmpDir}
}

# Clean up on exit
trap cleanup EXIT

# Clean up
cleanup

# Print generation
print "Running swagger-codegen..."

# Execute swagger-codegen
${SWAGGER_CODEGEN_COMMAND} generate -i ${remoteUrl} -l swift5 -o ${tmpDir}

# Copy generated files into swift package
cp -rf "${tmpDir}/SwaggerClient/Classes/Swaggers"/* "${swiftPackagePath}"

# Clean up with SwiftLint
swiftlint --fix

# Print contents of Cartfile. Might be used to check the dependency versions are correct in the Swift Package.
cartfile="${tmpDir}/Cartfile"
if [ -f "${cartfile}" ]; then
    print "Ensure dependices in Package.swift file match the Cartfile:"
    cat "${cartfile}"
fi

# Clean up
cleanup

# Print success
printGreen "swagger-codegen files successfully written to '${swiftPackagePath}'!"
