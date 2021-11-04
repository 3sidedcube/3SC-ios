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

# bitrise.yml
The [bitrise.yml](https://github.com/3sidedcube/3SC-ios/blob/master/bitrise.yml) is a common `bitrise.yml` file used in iOS projects.
It creates the following workflows:

* `install`: Fetch from the remote, install dependencies, and execute tests
* `app-store`: Sign, build, and upload to App Store Connect (should not be run individually)
* `live`: Run `install`, point at live environments, and then run `app-store`
* `staging`: Run `install`, point at staging environments, and then run `app-store`
* `test`: Run `install`, point at test environments, and then run `app-store`

When a PR is created, an `install` build is triggered to check that the app builds and its tests pass.
When `develop` is pushed, `live` is run to upload a new build to App Store Connect.

This file needs app specific changes, e.g. point at the App Store team ID.

## Usage
Use when creating a Bitrise app.

