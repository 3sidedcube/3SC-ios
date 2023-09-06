#!/usr/bin/env bash

#
# Script: send-fcm-push.sh
# Usage: ./send-fcm-push.sh
#
# Description:
# Send an FCM push notification using Firebase Cloud Messaging.
#
# Payload Interpolation:
# The payload file may add a {TOKEN} parameter that will be populated
# by this script.
#
# Documentation:
# https://firebase.google.com/docs/cloud-messaging/send-message#rest
#
# Getting a Bearer Access Token:
# https://stackoverflow.com/a/62670409/5024990
#

# Set defaults
set -o nounset -o errexit -o errtrace -o pipefail

# ============================== Custom Variables ==============================
# Please edit the following to your requirements

# Authentication to FCM
BEARER=""

# Firebase push token (not APNs device token)
FCM_TOKEN=""

# Firebase project ID
PROJECT_ID=""

# ============================== Fixed Variables ==============================

# Directory of this script
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Path to the notification payload file
PAYLOAD_FILE="${SCRIPT_DIR}/fcm-payload.json"

# ============================== Main ==============================

# Read payload from file and inject token parameter
payload=`cat ${PAYLOAD_FILE}`
payload=${payload/'{TOKEN}'/$FCM_TOKEN}

# Execute curl command
curl -X POST \
    -H "Authorization: Bearer ${BEARER}" \
    -H "Content-Type: application/json" \
    -d "${payload}" \
    "https://fcm.googleapis.com/v1/projects/${PROJECT_ID}/messages:send"
