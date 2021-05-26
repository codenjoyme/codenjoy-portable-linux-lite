#!/usr/bin/env bash

###
# #%L
# Codenjoy - it's a dojo-like platform from developers to developers.
# %%
# Copyright (C) 2012 - 2022 Codenjoy
# %%
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public
# License along with this program.  If not, see
# <http://www.gnu.org/licenses/gpl-3.0.html>.
# #L%
###
DB_DIR=/data/dojoserver
PROFILES=sqlite
GAME_AI=false
FORCE=false
CONTAINER_NAME=dojorena-game-server

mkdir -p $DB_DIR

function usage() {
    echo ""
    echo "Usage:"
    echo ""
    echo "$0 [OPTIONS]"
    echo "--sso                 - use OAuth2 authorization with telescopeai as an Authorization Server"
    echo "-f, --force           - forcefully kill already running instance if any"
    echo "-v, --debug           - turn off JS minification"
    echo "--ai                  - turn in AI bots for all the games except icancode as it's not supported"
    echo "--help                - usage"
    exit 1
}

while true; do
    case "$1" in
        --sso) SSO=true; shift ;;
        -v | --debug) PROFILES="$PROFILES,debug"; shift ;;
        -f | --force) FORCE=true; shift ;;
        --ai) GAME_AI=true; shift ;; 
        --help) usage ;;
        *) break ;;
    esac
done

if [ "$FORCE" = true ]; then
    docker rm -f $CONTAINER_NAME 2>/dev/null
fi 

docker run \
        -d \
        --name $CONTAINER_NAME \
        -e GAME_AI=$GAME_AI \
        -e SPRING_PROFILES_ACTIVE=$PROFILES \
        -v $DB_DIR:/usr/app/database \
        -p 8080:8080 \
        dojorena/game-server:1.1.1
