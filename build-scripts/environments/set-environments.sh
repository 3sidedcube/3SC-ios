#!/usr/bin/env bash

#
# Script: set-environments.sh
# Usage: ./set-environments.sh  [api-environment] [google-service-file]
# Arguments:
# - [api-environment]: API environment to set
# - [google-service-file]: GoogleService-Info.plist file
#
# Update the app API environment and GoogleService-Info.plist file.
#

# Set defaults
set -o nounset -o errexit -o errtrace -o pipefail

# ============================== Custom Constants ==============================

# Name of the project folder
PROJECT_FOLDER="{projectFolder}" # EDIT!

# API Environment Info.plist key
API_ENVIRONMENT="{apiEnvironment}" # EDIT!

# ============================== Constants ==============================

# Get directory path of this script
DIR="$(cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd)"

# Root of the source files in the Xcode project
XCODE_ROOT_PATH="${DIR}/../../${PROJECT_FOLDER}"

# Get the file path of the Info.plist file
INFO_PLIST_PATH="${XCODE_ROOT_PATH}/Info.plist"

# File name of the GoogleService-Info.plist file
GOOGLE_SERVICE_FILE_NAME="GoogleService-Info.plist"

# File path of the current GoogleService-Info.plist file
CURRENT_GOOGLE_SERVICE_FILE="${XCODE_ROOT_PATH}/${GOOGLE_SERVICE_FILE_NAME}"

# Directory where the GoogleService-Info.plist files are located
GOOGLE_SERVICE_DIRECTORY="${DIR}/GoogleServiceFiles"

# ============================== Main ==============================

# Check arguments
if [ "$#" -ne 2 ]; then
    echo "Usage $0 <${API_ENVIRONMENT}> <${GOOGLE_SERVICE_FILE_NAME}>" 1>&2
    exit 1
fi

# Set API environment
apiEnvironment=$1
plutil -replace "${API_ENVIRONMENT}" -string "${apiEnvironment}" "${INFO_PLIST_PATH}"

# File path of the new GoogleService-Info.plist file
newGoogleServiceFile="${GOOGLE_SERVICE_DIRECTORY}/$2"
if [ ! -f ${newGoogleServiceFile} ]; then
    echo "${GOOGLE_SERVICE_FILE_NAME} not found at: '${newGoogleServiceFile}'" 1>&2
    exit 1
fi

# Set Firebase environment
cp -f ${newGoogleServiceFile} ${CURRENT_GOOGLE_SERVICE_FILE}

