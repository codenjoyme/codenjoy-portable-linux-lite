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

if [ "$EUID" -ne 0 ]; then
    echo "[91mPlease run as root on the /srv/codenjoy folder[0m" ;
    exit ;
fi

HOME_DIR=$(
  cd $(dirname "$0")
  pwd
)
echo $HOME_DIR

eval_echo() {
    to_run=$1
    echo "[94m"
    echo $to_run
    echo "[0m"

    eval $to_run
}

DOCKER_IMAGE=apofig/codenjoy-contest:1.1.3
CONTEXT=/codenjoy-contest
SERVER_PORT=8080
PROFILES=sqlite,icancode
GAME_AI=true
ADMIN_PASSWORD=admin
CONTAINER_NAME=codenjoy

eval_echo "mkdir $HOME_DIR/logs"
eval_echo "chown $JETTY_PID:$JETTY_PID $HOME_DIR/logs"

eval_echo "touch $HOME_DIR/logs/codenjoy-contest.log"
eval_echo "chown $JETTY_PID:$JETTY_PID $HOME_DIR/logs/codenjoy-contest.log"

eval_echo "mkdir $HOME_DIR/database"
eval_echo "chown $JETTY_PID:$JETTY_PID $HOME_DIR/database"

eval_echo "docker rm --force $CONTAINER_NAME"

eval_echo "docker run -d --name $CONTAINER_NAME -e GAME_AI=$GAME_AI -e ADMIN_PASSWORD=$ADMIN_PASSWORD -e CONTEXT=$CONTEXT -e SPRING_PROFILES_ACTIVE=$PROFILES -v $HOME_DIR/database:/usr/app/database -p $SERVER_PORT:8080 $DOCKER_IMAGE"

eval_echo "docker attach $CONTAINER_NAME"
