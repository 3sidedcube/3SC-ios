#!/usr/bin/env bash

#
# Script: send-push-p12.sh
# Usage: ./send-push-p12
#
# Send a push notification using a p12 certificate.
# Make sure to edit the variables before sending a PN.
#
# Apple documentation:
# https://developer.apple.com/documentation/usernotifications/sending_push_notifications_using_command-line_tools
#

# Set defaults
set -o nounset -o errexit -o errtrace -o pipefail

# ============================== Variables ==============================
# The following variables should be edited before sending a PN

# App bundle ID
TOPIC="<bundleId>"

# Device token to send to
DEVICE_TOKEN="<deviceToken>"

# APNS host to connect to
APNS_HOST_NAME="api.push.apple.com" # api.sandbox.push.apple.com

# Path to P12 file
P12_FILE="</path/to/p12>"

# Password of P12 file
P12_PASSWORD="<passwordForP12>"

# ============================== Main ==============================

# Hit APNS
curl -v \
    --header "apns-topic: ${TOPIC}" \
    --header "apns-push-type: alert" \
    --cert-type P12 \
    --cert "${P12_FILE}:${P12_PASSWORD}" \
    --data '{"aps":{"alert":"Test"}}' \
    --http2 \
    https://${APNS_HOST_NAME}/3/device/${DEVICE_TOKEN}

