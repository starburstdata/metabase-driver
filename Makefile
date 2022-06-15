.PHONY: clone_metabase_if_missing clean link_to_driver front_end driver update_deps_files server test all release
.DEFAULT_GOAL := all
export MB_EDITION=ee

trino_version := $(shell jq '.trino' app_versions.json)
metabase_version := $(shell jq '.metabase' app_versions.json)

makefile_dir := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
is_trino_started := $(shell curl --fail --silent --insecure http://localhost:8080/v1/info | jq '.starting')

clone_metabase_if_missing:
ifneq ($(wildcard $(makefile_dir)/metabase/.*),)
	@echo "Did not find metabase, initializing..."; git submodule update --init --remote
else
	@echo "Found metabase, skipping initialization."
endif

checkout_latest_metabase_tag: clone_metabase_if_missing clean
	$(eval latest_metabase_version=$(shell cd $(makefile_dir)/metabase/modules/drivers && git tag | egrep 'v[0-9]+\.[0-9]+\.[0-9]+' | sort | tail -n 1))
	@echo "Checking out latest metabase tag: $(latest_metabase_version)"
	cd $(makefile_dir)/metabase/modules/drivers && git checkout $(latest_metabase_version);
	sed -i '' 's/metabase\": \".*\"/metabase\": \"$(latest_metabase_version)\"/g' app_versions.json;

start_trino_if_missing:
ifeq ($(is_trino_started),)
	@echo "Trino not started, starting using version $(trino_version)...";
	cd $(makefile_dir)/resources/docker/trino; docker build -t trino-metabase-test . --build-arg version=$(trino_version); docker run --rm -d  -p 8080:8080/tcp trino-metabase-test:latest
else
	@echo "Trino started, skipping initialization."
endif

clean:
	@echo "Force cleaning Metabase repo..."
	cd $(makefile_dir)/metabase/modules/drivers && git reset --hard

link_to_driver:
	@echo "Adding link to driver..."
	ln -sf ../../../drivers/starburst $(makefile_dir)/metabase/modules/drivers

front_end:
	@echo "Building Front End..."
	cd $(makefile_dir)/metabase/; yarn build && yarn build-static-viz

driver: update_deps_files
	@echo "Building Starburst driver..."
	cd $(makefile_dir)/metabase/; ./bin/build-driver.sh starburst

server: 
	@echo "Starting metabase..."
	cd $(makefile_dir)/metabase/; clojure -M:run

# This command adds the require starburst driver dependencies to the metabase repo.
update_deps_files:
	@if cd $(makefile_dir)/metabase && grep -q starburst deps.edn; \
		then \
			echo "Metabase deps file updated, skipping..."; \
		else \
			echo "Updating metabase deps file..."; \
			cd $(makefile_dir)/metabase/; sed -i.bak 's/\/test\"\]\}/\/test\" \"modules\/drivers\/starburst\/test\"\]\}/g' deps.edn; \
	fi

	@if cd $(makefile_dir)/metabase/modules/drivers && grep -q starburst deps.edn; \
		then \
			echo "Metabase driver deps file updated, skipping..."; \
		else \
			echo "Updating metabase driver deps file..."; \
			cd $(makefile_dir)/metabase/modules/drivers/; sed -i.bak "s/\}\}\}/\} \metabase\/starburst \{:local\/root \"starburst\"\}\}\}/g" deps.edn; \
	fi

test: start_trino_if_missing link_to_driver update_deps_files
	@echo "Testing tarburst driver..."
	cd $(makefile_dir)/metabase/; DRIVERS=starburst clojure -X:dev:drivers:drivers-dev:test

build: clone_metabase_if_missing update_deps_files link_to_driver front_end driver
