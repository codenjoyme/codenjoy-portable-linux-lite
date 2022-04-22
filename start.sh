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

source .env

HOME_DIR=$(
    cd $(dirname "$0")
    pwd
)

if [ ! -d "codenjoy" ]; then
    git clone --recursive https://github.com/codenjoyme/codenjoy.git
    git checkout master
fi

mkdir $HOME_DIR/logs
chown $JETTY_PID:$JETTY_PID $HOME_DIR/logs
touch $HOME_DIR/logs/codenjoy-contest.log
chown $JETTY_PID:$JETTY_PID $HOME_DIR/logs/codenjoy-contest.log
mkdir $HOME_DIR/database
chown $JETTY_PID:$JETTY_PID $HOME_DIR/database
docker rm --force $CONTAINER_NAME
docker run -d --name $CONTAINER_NAME -e SERVER_IP=$SERVER_IP -e GAME_AI=$GAME_AI -e ADMIN_PASSWORD=$ADMIN_PASSWORD -e CONTEXT=$CONTEXT -e SPRING_PROFILES_ACTIVE=$PROFILES -v $HOME_DIR/database:/usr/app/database -p $SERVER_PORT:8080 $DOCKER_IMAGE

