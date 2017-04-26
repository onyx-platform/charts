#!/bin/sh
# Seeds Kafka config file with
# runtime container information

# $1 config
# rest overrides
#====================
# Source container settings
CONTAINER_CORE_LIMIT=
CONTAINER_MAX_MEMORY=
. ./container-limits > /dev/null
#====================


KAFKA_CONFIG=""
KAFKA_JVM_OPTS="$(./container-limits)"
if [ -e "$1" ]; then
    echo "Found Kafka config: $1"
    KAFKA_CONFIG="$1"
else
    echo "Could not find Kafka config: $1"
    exit 1
fi

export KAFKA_HEAP_OPTS="$KAFKA_JVM_OPTS"
./bin/kafka-server-start.sh "$@"
