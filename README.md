# 3SC-ios
A repository of useful files and documentation for iOS development at [3 Sided Cube](https://3sidedcube.com/).
If you are a new starter, we have a [guide](https://github.com/3sidedcube/3SC-ios/blob/master/new-starters.md) to help you get set up.

## ios-gitignore
The [ios-gitignore](https://github.com/3sidedcube/3SC-ios/blob/master/ios-gitignore) is a common `.gitignore` file used in iOS projects.
Save as `.gitignore` in the root project directory.
Make sure not to get it confused with the `.gitignore` of this repository!

## ios-swiftlint.yml
The [ios-swiftlint.yml](https://github.com/3sidedcube/3SC-ios/blob/master/ios-swiftlint.yml) is a common `.swiftlint.yml` file used in iOS projects.
Save as `.swiftlint.yml` in the root project directory.

## ios-bitrise.yml
The [ios-bitrise.yml](https://github.com/3sidedcube/3SC-ios/blob/master/ios-bitrise.yml) is a common `bitrise.yml` file used in iOS projects.
It creates the following workflows:

* `install`: Fetch from the remote, install dependencies, and execute tests
* `app-store`: Sign, build, and upload to App Store Connect (should not be run individually)
* `live`: Run `install`, point at live environments, and then run `app-store`
* `staging`: Run `install`, point at staging environments, and then run `app-store`
* `test`: Run `install`, point at test environments, and then run `app-store`

The file contains the following triggers:

* When a PR is created, the `install` workflow is run.
* When `develop` is pushed, the `test` workflow is run.
* When `release/*` or `hotfix/*` are pushed, the `live` workflow is run.

This file needs app specific changes, e.g. point at the App Store Team ID.
Save as `bitrise.yml` in the root project directory.

### Documentation
There is a [Confluence page](https://3sidedcube.atlassian.net/wiki/spaces/IM/pages/2354413569) documenting the steps taken when creating an iOS app in Bitrise using a `bitrise.yml` file.

### Secret Environment Variables

* `APPLE_ID`
* `APPLE_ID_PASSWORD`
* `APP_SPECIFIC_PASSWORD`
* `GITHUB_ACCESS_TOKEN` (expose this for PRs)
* `SLACK_WEBHOOK`
* `APP_SLACK_WEBHOOK`

Note the `APP_SLACK_WEBHOOK` depends on the channel you want to post messages into.
You need to open the [3SC-Bitrise Slack app](https://api.slack.com/apps/A024S8Q7SKG) and add a new "Incoming Webhook".
The others are shared across apps and can be taken from another app.

#### Note

The Slack webhook will post all builds into the 3SC Bitrise channel.
The app Slack webhook can be used to post to specific channel.
The Slack webhook method is deprecated by Slack (but still works), the app webhook uses a Slack app.

### Environment Variables

* `BITRISE_PROJECT_PATH = <project-name>.xcodeproj`
* `BITRISE_SCHEME = <project-name>`
* `BITRISE_EXPORT_METHOD = app-store`
* `INFO_PLIST_PATH = <project-name>/Info.plist`
* `TEAM_ID = <team-id>`

### Helper Script
Create a `bitrise.yml` in your project by running:
```bash
bash -l -c "$(curl -sfL https://raw.githubusercontent.com/3sidedcube/3sc-ios/master/bitrise.sh)"
```

### Scripts
There are various scripts run by the `bitrise.yml` steps.
These can be found in the [build-scripts](https://github.com/3sidedcube/3SC-ios/blob/master/build-scripts) directory.
Make sure to edit them so they are relevant to your app.

## Sending Push Notifications

You can send yourself a push notification using a token (`p8`) or certificate (`p12`).
Both can be generated in the Apple Developer Console. 
In the case of `p12`, typically a `cer` file is installed to your keychain and then exported as a `p12`.

The scripts below follow the steps outlined by Apple in their PNs [command line tools documentation](https://developer.apple.com/documentation/usernotifications/sending_push_notifications_using_command-line_tools).
In both cases, make sure to **set the variables** at the top of the script before sending!

### Token (p8)
Send a push notification using a `p8` with [this script](https://github.com/3sidedcube/3SC-ios/blob/master/send-push-p8.sh).

### Certificate (p12)
Send a push notification using a `p12` with [this script](https://github.com/3sidedcube/3SC-ios/blob/master/send-push-p12.sh).
