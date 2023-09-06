#!/usr/bin/env bash

#
# Script: copy-google-service-file.sh 
# Usage: ./copy-google-service-file.sh
#
# Description:
# Copies the GoogleService-Info.plist file into the build directory as a resource.
# Ensure the ${GOOGLE_SERVICE_FILE} environment variable has been setup.
#
# Instructions:
# Make sure to check the input file path matches your project.
#
# Note:
# Some of the environment variables are injected by Xcode.
#

# Set defaults
set -o nounset -o errexit -o errtrace -o pipefail

# Path to GoogleService-Info.plist to copy
INPUT_PATH="${PROJECT_DIR}/${PROJECT_NAME}/Configuration/GoogleServices/${GOOGLE_SERVICE_FILE}"

# Destinaton path of GoogleService-Info.plist
OUTPUT_PATH="${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/GoogleService-Info.plist"

# Check that input file path exists
if [ ! -f "${INPUT_PATH}" ]; then
    echo "The GoogleService-Info.plist to copy does not exist: ${INPUT_PATH}." 1>&2
    exit 1
fi

# Copy the input file into the build directory as a resource
cp -r "${INPUT_PATH}" "${OUTPUT_PATH}"
