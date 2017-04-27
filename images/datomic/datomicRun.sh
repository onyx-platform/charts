#!/bin/sh

# $1 config
# rest overrides
#====================
# Source container settings
CONTAINER_CORE_LIMIT=
CONTAINER_MAX_MEMORY=
. ./container-limits > /dev/null
#====================

JVM_OPTS="$(./container-limits)"
echo "Starting datomic with opts: $JVM_OPTS"
./bin/transactor "$JVM_OPTS"
