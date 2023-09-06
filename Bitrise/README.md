# Bitrise

## bitrise.yml

A common `bitrise.yml` file used in iOS projects.
It creates the following workflows:

* `install`: Fetch from the remote, install dependencies, and execute tests
* `app-store`: Sign, build, and upload to App Store Connect (should not be run individually)
* `live`: Run `install`, point at live environments, and then run `app-store`
* `staging`: Run `install`, point at staging environments, and then run `app-store`
* `test`: Run `install`, point at test environments, and then run `app-store`
* `dev`: Run `install`, point at dev environments, and then run `app-store`

The file contains the following triggers:

* When a PR is created, the `install` workflow is run.
* When `develop` is pushed, the `test` workflow is run.
* When `release/*` or `hotfix/*` are pushed, the `live` workflow is run.

This file needs app specific changes, e.g. point at the App Store Team ID.
Save as `bitrise.yml` in the root project directory.

### Documentation

* There is a [Bitrise Setup](https://3sidedcube.atlassian.net/wiki/spaces/IM/pages/2354413569) Confluence page documenting the steps taken when creating an iOS app in Bitrise using a `bitrise.yml` file.
* There is a [Bitrise Monthly 2FA](https://3sidedcube.atlassian.net/l/cp/28cp3Fv5) Confluence page documenting the steps required to reauthenticate Bitrise (Apple Service Connection) 2FA each month.

### Secret Environment Variables

* `APPLE_ID`
* `APPLE_ID_PASSWORD`
* `APP_SPECIFIC_PASSWORD`
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
bash -l -c "$(curl -sfL https://raw.githubusercontent.com/3sidedcube/3sc-ios/develop/Bitrise/bitrise.sh)"
```