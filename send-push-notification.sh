#!/bin/sh
#
# Apple Reference:
# https://developer.apple.com/documentation/usernotifications/sending_push_notifications_using_command-line_tools
#

# App bundle ID
TOPIC="<app-bundle-id>"

# Device token to send to
DEVICE_TOKEN="<device-token>"

# APNS host to connect to
APNS_HOST_NAME="api.push.apple.com" # api.sandbox.push.apple.com

# Path to P12 file
P12_FILE="<path-to-p12>"

# Password of P12 file
P12_PASSWORD="<p12-password>"

# Hit APNS
curl -v \
    --header "apns-topic: ${TOPIC}" \
    --header "apns-push-type: alert" \
    --cert-type P12 \
    --cert "${P12_FILE}:${P12_PASSWORD}" \
    --data '{"aps":{"alert":"Test"}}' \
    --http2 \
    https://${APNS_HOST_NAME}/3/device/${DEVICE_TOKEN}

