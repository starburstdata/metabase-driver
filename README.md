# Metabase Starburst Driver

## Driver Plugin Installation
The Starburst Driver `.jar` binary can be downloaded from our releases in github. Once it is downloaded, 
it must be stored in the `plugins` directory within the Metabase working dir. See: https://www.metabase.com/docs/latest/developers-guide-drivers.html#how-to-use-a-third-party-driver

## Developers Guide Drivers

Our build scripts will git clone the Metabase repo to `./metabase` and copy all Starburst driver files into the 
expected folder: `./metabase/modules/drivers/starburst`. From here, we leverage the Metabase build scripts to 
build our `.jar` file into the correct dir, run tests, and start the local server.

### Dependencies

* [Docker](https://www.docker.com/)
* [Clojure](https://clojure.org/guides/install_clojure)

##### Quick Start
Run `make build test` to build and run tests locally. If everything passes, you're good to go!

### Building
Run `make build` to clone the Metabase repo and build all required components. This command should not need
to be run again unless you manually git pull new changes into your local Metabase repo.

#### Force Updating Metabase Repo
You can manually run git commands to update the cloned Metabase repo, but if you want to remove 
the local Metabase repo and re-clone with the latest changes, `make clean`

### Starting Local Server
Once you have built all required resources with the `make build` command, run `make server`. 
This command starts a local Metabase server on port `3000`. If you want to build the driver and then start a server, run `make driver server`.

### Testing Driver
Once you have built all required resources with the `make build` command, run `make test`. This command builds your local driver changes and then starts Starburst driver tests.

#### Executing Specific Tests
You can cd into the metabase repo and run commands like:
`DRIVERS=starburst clojure -X:dev:drivers:drivers-dev:test :only metabase.query-processor-test.timezones-test/filter-test`

or even

`DRIVERS=starburst clojure -X:dev:drivers:drivers-dev:test :only metabase.query-processor-test.timezones-test`

### Releasing Driver
To create a release from the `main` branch follow the below steps.

#### 1.) Create a Release Branch
Head to actions and run the `Create Release Branch` workflow entering in the correct semantic version, and submit the workflow. This will create a new PR that contains promoted CHANGELOG.md and updated version info. Review the PR and merge once checks pass.

#### 2.) Create the Release Artifact 
Head to actions and run the `Release` workflow entering the same the same semantic version, and submit the release workflow. When this workflow completes, it will create a new tagged github release with the provided version and upload the `.jar` binary for clients to consume.

### Update Metabase Version
If needed, `make checkout_latest_metabase_tag` will update Metabase to its latest tagged release. 

## References
* [Encrypting Metabase Database Details](https://www.metabase.com/docs/latest/operations-guide/encrypting-database-details-at-rest.html)
* [Developer's Guide](https://www.metabase.com/docs/latest/developers-guide/start.html)
* [Developer's Environment Guide](https://www.metabase.com/docs/latest/developers-guide/devenv.html)
* [Driver Developer's Guide](https://www.metabase.com/docs/latest/developers-guide-drivers.html#driver-development)
* [Driver Development Announcements](https://www.metabase.com/docs/latest/developers-guide-drivers.html#driver-development-announcements)
* [Driver Development Form](https://discourse.metabase.com/c/driver-development)
* [Metabase](https://www.metabase.com/)
* [Learn Clojure](https://clojure.org/guides/learn/clojure)
* [Clojure Docs](https://clojuredocs.org/clojure.core)
* [Clojure Cheatsheet](https://clojure.org/api/cheatsheet)
* [Clojure JDBC](https://clojure-doc.org/articles/ecosystem/java_jdbc/using_sql/)
* [Clojure](https://clojure.org/index)

## Contact
For feature requests and bugs, please create an issue in this repo. For further support, see the following resources:
* [Trino Slack](https://trino.io/slack.html)
