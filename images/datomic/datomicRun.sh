#!/bin/sh

# $1 config
# rest overrides
#====================
# Source container settings
. ./container-limits > /dev/null
#====================

if [ -n "$(jmax_memory)" ]; then
    echo "Found max memory settings from cgroup limits $(jmax_memory)"
    export XMX="$(jmax_memory)"
    export XMS="$(jmax_memory)"
fi

echo "Datomic config file: $1"
./bin/transactor "$1"
