#!/usr/bin/env bash

#
# Script: send-push-p8.sh
# Usage: ./send-push-p8
#
# Send a push notification using a p8 token.
# Make sure to edit the variables before sending a PN.
#
# Apple documentation:
# https://developer.apple.com/documentation/usernotifications/sending_push_notifications_using_command-line_tools
#

# Set defaults
set -o nounset -o errexit -o errtrace -o pipefail

# ============================== Variables ==============================
# The following variables should be edited before sending a PN

# App Store team identifier
TEAM_ID="<teamId>"

# Path to p8 token file
TOKEN_KEY_FILE_NAME="</path/to/p8>"

# Key identifier of the token
AUTH_KEY_ID="<keyId>"

# App bundle ID
TOPIC="<bundleId>"

# Device token to send to
DEVICE_TOKEN="<deviceToken>"

# APNS host to connect to
APNS_HOST_NAME="api.push.apple.com" # api.sandbox.push.apple.com

# ============================== JWT ==============================

JWT_ISSUE_TIME=$(date +%s)
JWT_HEADER=$(printf '{ "alg": "ES256", "kid": "%s" }' "${AUTH_KEY_ID}" | openssl base64 -e -A | tr -- '+/' '-_' | tr -d =)
JWT_CLAIMS=$(printf '{ "iss": "%s", "iat": %d }' "${TEAM_ID}" "${JWT_ISSUE_TIME}" | openssl base64 -e -A | tr -- '+/' '-_' | tr -d =)
JWT_HEADER_CLAIMS="${JWT_HEADER}.${JWT_CLAIMS}"
JWT_SIGNED_HEADER_CLAIMS=$(printf "${JWT_HEADER_CLAIMS}" | openssl dgst -binary -sha256 -sign "${TOKEN_KEY_FILE_NAME}" | openssl base64 -e -A | tr -- '+/' '-_' | tr -d =)
AUTHENTICATION_TOKEN="${JWT_HEADER}.${JWT_CLAIMS}.${JWT_SIGNED_HEADER_CLAIMS}"

# ============================== Main ==============================

curl -v \
  --header "apns-topic: $TOPIC" \
  --header "apns-push-type: alert" \
  --header "authorization: bearer $AUTHENTICATION_TOKEN" \
  --data '{"aps":{"alert":"test"}}' 
  --http2 https://${APNS_HOST_NAME}/3/device/${DEVICE_TOKEN}

