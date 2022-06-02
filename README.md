# Metabase Starburst Driver

## Installation
Driver `.jar` files must be stored in a `plugins` directory within the Metabase working dir.
Our build scripts will git clone the Metabase repo to `./metabase` and copy all Starburst driver files into the 
expected folder: `./metabase/modules/drivers/starburst`. From here, we leverage the Metabase build scripts to 
build our `.jar` file into the correct dir, run tests, and start the local server.

## Building
Run `make build` to clone the Metabase repo and build all required components. This command should not need
to be run again unless you manually git pull new changes into your local Metabase repo.

### Force Updating Metabase Repo
You can manually run git commands to update the cloned Metabase repo, but if you want to remove 
the local Metabase repo and re-clone with the latest changes, `make clean`

## Starting Local Server
Once you have built all required resources with the `make build` command, run `make server`. 
This command starts a local Metabase server on port `3000`. If you want to build the driver and then start a server, run `make driver server`.

## Testing Driver
Once you have built all required resources with the `make build` command, run `make test`. This command builds your local driver changes and then starts Starburst driver tests.

## Releasing Driver
To create a release from the `main` branch, head to actions and create a new release workflow. 
Enter in the correct semantic version, and submit the release. This will create a new tag and 
release with the provided version, as well as promote the CHANGELOG.md and upload the `.jar` 
binary for clients to consume.

## References
* [Developer's Guide](https://www.metabase.com/docs/latest/developers-guide/start.html)
* [Developer's Environment Guide](https://www.metabase.com/docs/latest/developers-guide/devenv.html)
* [Driver Developer's Guide](https://www.metabase.com/docs/latest/developers-guide-drivers.html#driver-development)
* [Driver Development Announcements](https://www.metabase.com/docs/latest/developers-guide-drivers.html#driver-development-announcements)
* [Driver Development Form](https://discourse.metabase.com/c/driver-development)
* [Metabase](https://www.metabase.com/)
