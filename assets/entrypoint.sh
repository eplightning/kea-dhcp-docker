#!/bin/bash

if [ -n "$DB_ADMIN_PARAMS" ]; then
  # TODO: check version before doing db-init, needs to be fixed in Kea upstream ...
  # TODO: because right now it always exits with 0 even if it fails to get that version

  # db-init will fail if there's database already so it should be safe
  kea-admin db-init $DB_ADMIN_PARAMS
  init_error=$?

  # TODO: currently this will try upgrade on every error ...
  # TODO: postgres backend returns 2 if it failed because of existing error ...
  # TODO: however mysql backend does not ...
  # TODO: and therefore until mysql kea admin tools get fixed this is the best we can do
  if [ $init_error -ne 0 ]; then
    kea-admin db-upgrade $DB_ADMIN_PARAMS
    upgrade_error=$?

    if [ $upgrade_error -ne 0 ]; then
      exit 1
    fi
  fi
fi

if [ -z "$1" ]; then
  exec supervisord --configuration /kea/assets/supervisord.conf
else
  exec "${@:1}"
fi
