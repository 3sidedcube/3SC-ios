#!/usr/bin/env bash

#
# Script: send-push-p8.sh
# Usage: ./send-push-p8
#
# Description:
# Send a push notification using a p8 token.
#
# Documentation:
# https://developer.apple.com/documentation/usernotifications/sending_push_notifications_using_command-line_tools
#

# Set defaults
set -o nounset -o errexit -o errtrace -o pipefail

# Directory of this script
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# ============================== Variables ==============================
# Please edit the following to your requirements

# App Store team identifier
TEAM_ID="<teamId>"

# Path to p8 token file
TOKEN_KEY_FILE="</path/to/p8>"

# Key identifier of the token
AUTH_KEY_ID="<keyId>"

# App bundle ID
TOPIC="<bundleId>"

# Device token to send to
DEVICE_TOKEN="<deviceToken>"

# APNS host to connect to
APNS_HOST_NAME="api.push.apple.com" # api.sandbox.push.apple.com

# Type of push
PUSH_TYPE="alert" # background

# Path to the notification payload file
PAYLOAD_FILE="${SCRIPT_DIR}/apns-payload.json"

# ============================== JWT ==============================

JWT_ISSUE_TIME=$(date +%s)
JWT_HEADER=$(printf '{ "alg": "ES256", "kid": "%s" }' "${AUTH_KEY_ID}" | openssl base64 -e -A | tr -- '+/' '-_' | tr -d =)
JWT_CLAIMS=$(printf '{ "iss": "%s", "iat": %d }' "${TEAM_ID}" "${JWT_ISSUE_TIME}" | openssl base64 -e -A | tr -- '+/' '-_' | tr -d =)
JWT_HEADER_CLAIMS="${JWT_HEADER}.${JWT_CLAIMS}"
JWT_SIGNED_HEADER_CLAIMS=$(printf "${JWT_HEADER_CLAIMS}" | openssl dgst -binary -sha256 -sign "${TOKEN_KEY_FILE}" | openssl base64 -e -A | tr -- '+/' '-_' | tr -d =)
AUTHENTICATION_TOKEN="${JWT_HEADER}.${JWT_CLAIMS}.${JWT_SIGNED_HEADER_CLAIMS}"

# ============================== Main ==============================

# Read payload from file
payload=`cat ${PAYLOAD_FILE}`

curl -v \
  --header "apns-topic: ${TOPIC}" \
  --header "apns-push-type: ${PUSH_TYPE}" \
  --header "authorization: bearer ${AUTHENTICATION_TOKEN}" \
  --data "${payload}" \
  --http2 \
  "https://${APNS_HOST_NAME}/3/device/${DEVICE_TOKEN}"

