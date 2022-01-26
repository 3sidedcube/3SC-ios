# 3SC-ios
A repository of useful files for iOS development.

# install-depedencies.sh
The [install-depedencies.sh](https://github.com/3sidedcube/3SC-ios/blob/master/install-dependencies.sh) script is used to download and install dependencies used in an iOS app.
Some dependencies are assumed, such as `xcodebuild` and `ruby`.
The dependencies which are installed are:
- [Homebrew](https://brew.sh/) for installing software packages
- [SwiftLint](https://github.com/realm/SwiftLint) for linting in Swift
- [Carthage](https://github.com/Carthage/Carthage) for building binary frameworks

## Usage

To fetch and run the script:

```bash
# URL of the script to install iOS project dependencies
INSTALL_DEPENDENCIES_SCRIPT_URL="https://raw.githubusercontent.com/3sidedcube/3SC-ios/master/install-dependencies.sh"

# Fetch install script and pass in command line arguments
curl -sfL ${INSTALL_DEPENDENCIES_SCRIPT_URL} | bash -s -- $@
```

To skip installing the dependencies pass `--skip-dependencies` as a command line argument.

# ios-gitignore
The [ios-gitignore](https://github.com/3sidedcube/3SC-ios/blob/master/ios-gitignore) is a common `.gitignore` file used in iOS projects.

## Usage
Bring into the root of your project as the `.gitignore` file.

# ios-swiftlint.yml
The [ios-swiftlint.yml](https://github.com/3sidedcube/3SC-ios/blob/master/ios-swiftlint.yml) is a common `.swiftlint.yml` file used in iOS projects.

## Usage
Bring into the root of your project as the `.swiftlint.yml` file.

# ios-bitrise.yml
The [ios-bitrise.yml](https://github.com/3sidedcube/3SC-ios/blob/master/ios-bitrise.yml) is a common `bitrise.yml` file used in iOS projects.
It creates the following workflows:

* `install`: Fetch from the remote, install dependencies, and execute tests
* `app-store`: Sign, build, and upload to App Store Connect (should not be run individually)
* `live`: Run `install`, point at live environments, and then run `app-store`
* `staging`: Run `install`, point at staging environments, and then run `app-store`
* `test`: Run `install`, point at test environments, and then run `app-store`

When a PR is created, an `install` build is triggered to check that the app builds and its tests pass.
When `develop` is pushed, `live` is run to upload a new build to App Store Connect.

This file needs app specific changes, e.g. point at the App Store team ID.

## Secret Environment Variables

* `APPLE_ID`
* `APPLE_ID_PASSWORD`
* `APP_SPECIFIC_PASSWORD`
* `GITHUB_ACCESS_TOKEN` (expose this for PRs)
* `SLACK_WEBHOOK`
* `APP_SLACK_WEBHOOK`

### Note

The Slack webhook will post all builds into the 3SC Bitrise channel.
The app Slack webhook can be used to post to specific channel.
The Slack webhook method is deprecated by Slack (but still works), the app webhook uses a Slack app.

## Environment Variables

* `BITRISE_PROJECT_PATH = <project-name>.xcodeproj`
* `BITRISE_SCHEME = <project-name>`
* `BITRISE_EXPORT_METHOD = app-store`
* `INFO_PLIST_PATH = <project-name>/Info.plist`
* `TEAM_ID = <team-id>`

## Usage
Use when creating a Bitrise app. Can be stored in the project repository.

## Helper Script
Create a `bitrise.yml` in your project by running:
```bash
bash -l -c "$(curl -sfL https://raw.githubusercontent.com/3sidedcube/3sc-ios/develop/bitrise.sh)"
```

# Sending Push Notifications

After creating an APNS certificate in the Apple developer console, you can install it in your keychain and export it as a `.p12` file.
[This script](https://github.com/3sidedcube/3SC-ios/blob/master/send-push-notification.sh), once the variables are set, can then be used to send a push notification.
It follows the steps outlined by Apple in their PNs command line documentation [here](https://developer.apple.com/documentation/usernotifications/sending_push_notifications_using_command-line_tools) but with P12 files.

