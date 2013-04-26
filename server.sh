#!/usr/bin/env bash
# -------------------------------------------------------------------
# Copyright (C) 2013 Alex Levinson
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see http://www.gnu.org/licenses/
# -------------------------------------------------------------------
USAGE="Usage: $(basename $0) -p PORT [-h for help]"
# -------------------------------------------------------------------
server ()
{
  rm -f ./._b > /dev/null 2>&1
  mkfifo ./._b
  nc -lk $1 0<._b | while true; do read VALUE; ACTION=$(echo "$VALUE" | cut -d' ' -f1); KEY=$(echo "$VALUE" | cut -d' ' -f2 | sed 's/[^a-z_]//g;'); VALUE=$(echo "$VALUE" | sed "s/$ACTION $KEY //;"); case $ACTION in GET) cat db/$KEY ;; SET) echo "$VALUE" > db/$KEY ; echo "OK" ;; *) echo "ERROR - UNKNOWN COMMAND" ;; esac done &>._b
}
# -------------------------------------------------------------------
if ( ! getopts "p:h" opt); then
  echo "$USAGE"
  exit $E_OPTERROR;
fi
# -------------------------------------------------------------------
while getopts "p:h" opt; do
  case $opt in
    h) echo "$USAGE";;
    p) server $OPTARG;;
  esac
done
# -------------------------------------------------------------------
