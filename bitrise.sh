#!/bin/sh

#
# Create a bitrise.yml after taking user input
#  
# Usage:
# $ ./bitrise.sh
#

# File to write
BITRISE_FILE="bitrise.yml"

# Template file
TEMPLATE_BITRISE_FILE="template-bitrise.yml"

# Remote script to fetch template file
TEMPLATE_BITRISE_FILE_URL="https://raw.githubusercontent.com/3sidedcube/3sc-ios/develop/ios-bitrise.yml" # TODO

# Red color
RED='\033[0;31m'

# Green color
GREEN='\033[0;32m'

# Yellow color
YELLOW='\033[0;33m'

# No color
NC='\033[0m'

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
fatalError() {
    printRed "$1" 1>&2
    exit 1
}

# Prompt the user for input.
# Returns the response string.
prompt() {
    local response
    read -r -p "$(printYellow $1) " response
    echo "${response}"
}

# Prompt the user for yes or no input.
# Returns 0 on (a variation of) yes, 1 otherwise.
promptYN() {
    local response=$(prompt "$1 [y/N]")
    if [[ "${response}" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        return 0 # 0 for exit success, not to be confused with false
    else
        return 1 # 1 for exit failure, not to be confused with true
    fi
}

# Check input is not empty
checkNotEmpty() {
    if [ -z "$1" ]; then
        fatalError "Input can not be empty. Exiting..."
    fi
}

# Clean up temporary files
function cleanup {
    rm -rf "${TEMPLATE_BITRISE_FILE}"
}

# Abort script if a command fails
set -e

# Clean up on exit
trap cleanup EXIT

# ============================== Start ==============================

# Clean up
cleanup

# Starting
print "Running script to generate '${BITRISE_FILE}'..."

# Warn the user the file will be deleted if it already exists
if [ -f "${BITRISE_FILE}" ]; then
    message="A '${BITRISE_FILE}' file already exists, would you like to overwrite?"
    if ! promptYN "${message}"; then
        fatalError "Do not overwrite. Exiting..."
    fi
fi

# Enter project name
projectName=$(prompt "Please enter a project name")
checkNotEmpty "${projectName}"

# Enter team ID
teamId=$(prompt "Please enter the App Store Team ID")
checkNotEmpty "${teamId}"

# Fetch template file
curl -s -H 'Cache-Control: no-cache' "${TEMPLATE_BITRISE_FILE_URL}" -o "${TEMPLATE_BITRISE_FILE}"

# Remove previous file if it exists
rm -rf ${BITRISE_FILE}

# Make new file
cp ${TEMPLATE_BITRISE_FILE} ${BITRISE_FILE}

# Replace project name
sed -i '' "s/{projectName}/${projectName}/g" ${BITRISE_FILE} # Command for Mac users

# Replace team ID
sed -i '' "s/{teamId}/${teamId}/g" ${BITRISE_FILE} # Command for Mac users

# Clean up
cleanup

# Complete with success
printGreen "${BITRISE_FILE} successfully written"

