#!/bin/bash

function log() {
 echo -e "\u001b[32m[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $*\u001b[0m"
}

if [ -f /tmp/trino-initialized ]; then
 exec /bin/sh -c "$@"
fi

TRINO_CATALOG_DIR="/etc/trino/catalog"

# Catalogs required to run metabase tests that all use the memory connector
MEMORY_CATALOGS="a-checkin-every-15-seconds 
memory 
a-checkin-every-86400-seconds 
office_checkins 
a-checkin-every-900-seconds 
places-cam-likes 
a_checkin_every_15_seconds 
places_cam_likes 
a_checkin_every_86400_seconds 
postgres 
a_checkin_every_900_seconds 
sad-toucan-incidents 
airports 
sad_toucan_incidents 
attempted_murders 
sample_database 
avian-singles 
sample_dataset 
avian_singles 
string_times 
checkins test-data-with-time 
checkins_interval_15 
test-data 
checkins_interval_86400 
test_data 
checkins_interval_900 
test_data_with_time 
daily_bird_counts 
test_data_with_timezones 
geographical-tips 
toucan_microsecond_incidents 
geographical_tips 
half-valid-urls 
half_valid_urls 
tupac-sightings 
tupac_sightings
times_mixed"

for catalog in $MEMORY_CATALOGS
do
log "Set up catalog file ${TRINO_CATALOG_DIR}/$catalog"
cat << EOF >> "${TRINO_CATALOG_DIR}/${catalog}.properties"
connector.name=memory
EOF
done

touch /tmp/trino-initialized

log "Executing cmd: ${*}"
exec /bin/sh -c "${@}"
