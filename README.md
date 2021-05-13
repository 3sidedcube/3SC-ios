# 3SC-ios
A repository of useful files for iOS development.

# install-depedencies.sh
The [install-depedencies.sh](https://github.com/3sidedcube/3SC-ios/tree/master/install-depedencies.sh) script is used to download and install dependencies used in an iOS app.
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

# ios-gitignore.txt
The [ios-gitignore.txt](https://github.com/3sidedcube/3SC-ios/tree/master/ios-gitignore.txt) is a common `.gitignore` file used in iOS projects.

## Usage
Bring into the root of your `.xcodeproj` project as the `.gitignore` file.

