#!/usr/bin/env bash

#
# Script: send-push-p12.sh
# Usage: ./send-push-p12
#
# Description:
# Send a push notification using a p12 certificate.
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

# App bundle ID
TOPIC="<bundleId>"

# Device token to send to
DEVICE_TOKEN="<deviceToken>"

# Path to P12 file
P12_FILE="</path/to/p12>"

# Password of P12 file
P12_PASSWORD="<passwordForP12>"

# APNS host to connect to
APNS_HOST_NAME="api.push.apple.com" # api.sandbox.push.apple.com

# Type of push
PUSH_TYPE="alert" # background

# Path to the notification payload file
PAYLOAD_FILE="${SCRIPT_DIR}/apns-payload.json"

# ============================== Main ==============================

# Read payload from file
payload=`cat ${PAYLOAD_FILE}`

# Hit APNS
curl -v \
    --header "apns-topic: ${TOPIC}" \
    --header "apns-push-type: ${PUSH_TYPE}" \
    --cert-type P12 \
    --cert "${P12_FILE}:${P12_PASSWORD}" \
    --data "${payload}" \
    --http2 \
    "https://${APNS_HOST_NAME}/3/device/${DEVICE_TOKEN}"

