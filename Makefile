.PHONY: clone_metabase_if_missing clean copy_to_metabase front_end driver server test all release
.DEFAULT_GOAL := all
export MB_EDITION=ee

trino_version := $(shell jq '.trino' app_versions.json)

makefile_dir := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
is_trino_started := $(shell curl --fail --silent --insecure http://localhost:8080/v1/info | jq '.starting')

clone_metabase_if_missing:
ifneq ($(wildcard $(makefile_dir)/metabase/.*),)
	@echo "Did not find metabase, initializing..."; git submodule update --init --remote
else
	@echo "Found metabase, skipping initialization."
endif

start_trino_if_missing:
ifeq ($(is_trino_started),)
	@echo "Trino not started, starting using version $(trino_version)...";
	cd $(makefile_dir)/resources/docker/trino; docker build -t trino-metabase-test . --build-arg version=$(trino_version); docker run --rm -d  -p 8080:8080/tcp trino-metabase-test:latest
else
	@echo "Trino started, skipping initialization."
endif

clean:
	@echo "Force cloning Metabase repo..."
	git submodule update --init --recursive --force --remote

copy_to_metabase:
	@echo "Copying to metabase..."
	cp -R $(makefile_dir)/drivers/starburst $(makefile_dir)/metabase/modules/drivers

front_end:
	@echo "Building Front End..."
	cd $(makefile_dir)/metabase/; yarn build && yarn build-static-viz

driver:
	@echo "Building Starburst driver..."
	cd $(makefile_dir)/metabase/; ./bin/build-driver.sh starburst

server: 
	@echo "Starting metabase..."
	cd $(makefile_dir)/metabase/; clojure -M:run

test: start_trino_if_missing copy_to_metabase
	@echo "Testing tarburst driver..."
	cd $(makefile_dir)/metabase/; DRIVERS=starburst clojure -X:dev:drivers:drivers-dev:test

build: clone_metabase_if_missing copy_to_metabase front_end driver
