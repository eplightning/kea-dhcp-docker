#!/bin/bash -e

# TODO: DB Init

if [ -z "$1" ]; then
  exec supervisord --configuration /kea/assets/supervisord.conf
else
  exec "${@:1}"
fi
