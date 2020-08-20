#!/bin/bash

[ -z "$1" ] && exit 1

env_name=DISABLE_$(echo -n "$1" | tr - _ | tr [:lower:] [:upper:])
binary_name=kea-$1
config_name=kea-$1.conf

if [ "${!env_name}" == "1" ]; then
  sleep 5
  exit 0
fi

exec "$binary_name" -c "/kea/config/$config_name"
