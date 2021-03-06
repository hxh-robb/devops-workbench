#!/usr/bin/env bash

CMD=$(readlink -f "$0")
DIR=$(dirname "$CMD")
cd "${DIR}"

[ ! -x "mod-list.sh" ] && echo "[mod-list.sh] is missing, cannot perform module dockerizing!" && exit 1

##############################
## Import Functions
##############################
[ ! -f "mod-func/_dockerize.sh" ] && echo "[mod-func/_dockerize.sh] is missing, cannot perform module dockerizing!" && exit 1
source mod-func/_dockerize.sh

##############################
## Parameters
##############################
# TODO:--dry-run
if [ $# -eq 0 ]; then
  mods=$(./mod-list.sh --name-only)
else
  mods="$@"
fi

##############################
## Performing dockerization
##############################
for mod in ${mods}; do
  [ ! -d modules/${mod} ] && echo "[${mod}] does not exists" && continue
  dockerize modules/${mod}
done
