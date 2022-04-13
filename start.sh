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

eval_echo() {
    to_run=$1
    echo "[94m"
    echo $to_run
    echo "[0m"
    
    eval $to_run
}

if [ ! -d "codenjoy" ]; then
    GIT_REPO=https://github.com/codenjoyme/codenjoy.git
    GIT_REVISION=master
    
    eval_echo "git clone --recursive $GIT_REPO"
    eval_echo "git checkout $GIT_REVISION"
fi

if [[ "$(docker images -q $DOCKER_IMAGE 2> /dev/null)" == "" ]]; then
    DOCKER_IMAGE=apofig/codenjoy-contest:1.1.3
    
    eval_echo "docker build --build-arg GAMES=$GAMES -f ./Dockerfile -t $DOCKER_IMAGE ."
fi

eval_echo "mkdir $HOME_DIR/logs"
eval_echo "chown $JETTY_PID:$JETTY_PID $HOME_DIR/logs"

eval_echo "touch $HOME_DIR/logs/codenjoy-contest.log"
eval_echo "chown $JETTY_PID:$JETTY_PID $HOME_DIR/logs/codenjoy-contest.log"

eval_echo "mkdir $HOME_DIR/database"
eval_echo "chown $JETTY_PID:$JETTY_PID $HOME_DIR/database"

eval_echo "docker rm --force $CONTAINER_NAME"

eval_echo "docker run -d --name $CONTAINER_NAME -e SERVER_IP=$SERVER_IP -e GAME_AI=$GAME_AI -e ADMIN_PASSWORD=$ADMIN_PASSWORD -e CONTEXT=$CONTEXT -e SPRING_PROFILES_ACTIVE=$PROFILES -v $HOME_DIR/database:/usr/app/database -p $SERVER_PORT:8080 $DOCKER_IMAGE"

eval_echo "docker attach $CONTAINER_NAME"

