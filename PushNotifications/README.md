# Push Notifications

A collection of useful scripts to send push notifications.

# Apple Push Notification service (APNs)

The scripts below follow the steps outlined by Apple in their PNs [command line tools documentation](https://developer.apple.com/documentation/usernotifications/sending_push_notifications_using_command-line_tools).

There is a script to send a PN through APNs using a `p8` token or `p12` certificate file.
Both auth files can be generated in the Apple Developer Console.
In the case of `p12`, typically a `cer` file is installed to your keychain and then exported as a `p12`.
By default, the JSON payload is read from the `apns-payload.json` file.
Edit this payload file to your requirements.
Make sure to also edit the variables in the script for your use case.

# Firebase Cloud Messaging (FCM)

Script available to send a PN through Firebase.
By default, the JSON payload is read from the `fcm-payload.json` file.
Edit this payload file to your requirements.
Make sure to also edit the variables in the script for your use case.
Check the documentation in the script to get a bearer token.
