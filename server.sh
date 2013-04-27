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
USAGE="Usage: $(basename $0) -p PORT [-h for help] [-l to log]"
# -------------------------------------------------------------------
server ()
{
  # Server can be written as one line, but for n00b 
  # readability will be broken up into several.
  rm -f ./._b > /dev/null 2>&1
  mkfifo ./._b
  exec 3<&1 # fd 3 can be used inside the while loop to write to local stdout
  nc -lk $1 0<._b | \
    while read ACTION KEY VALUE; do 
      KEY=${KEY//[^-0-9a-zA-Z_@.]/}
      $log && echo "incoming: $ACTION $KEY" >&3
      case "$ACTION" in 
        GET) cat "db/$KEY";; #echo "$(< "db/$KEY")" ;; 
        SET) echo "$VALUE" > "db/$KEY" ; echo "OK" ;; 
          *) echo "ERROR - UNKNOWN COMMAND" ;; 
      esac 
    done &>._b
}
# -------------------------------------------------------------------
if ( ! getopts "lp:h" opt); then
  echo "$USAGE"
  exit $E_OPTERROR;
fi
# -------------------------------------------------------------------
log=false
port=
while getopts "lp:h" opt; do
  case $opt in
    l) log=true;;
    h) echo "$USAGE";;
    p) port=$OPTARG;;
  esac
done
shift $((OPTIND - 1))
server "$port"
# -------------------------------------------------------------------
