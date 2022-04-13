######################################################
#           Game Server project build
######################################################
FROM maven:3.6.3-openjdk-11 as BUILD
LABEL maintainer="Igor Petrov"

# comma-separated list of games or 'allGames'
# TODO for all games sould be -P parameter in 'mvn clean package' command
ARG GAMES

WORKDIR /codenjoy

COPY ./codenjoy/CodingDojo/games ./games
COPY ./codenjoy/CodingDojo/server ./server
COPY ./codenjoy/CodingDojo/balancer ./balancer
COPY ./codenjoy/CodingDojo/utilities ./utilities
COPY ./codenjoy/CodingDojo/clients ./clients
COPY ./codenjoy/CodingDojo/client-runner ./client-runner
COPY ./codenjoy/CodingDojo/pom.xml ./pom.xml

RUN mvn clean package -D$GAMES -DskipTests

######################################################
#                 Game Server image
######################################################
FROM openjdk:11 as SERVER
LABEL maintainer="Igor Petrov"

ENV APP_HOME=/usr/app

ENV ARTIFACT_NAME=codenjoy-contest.war

WORKDIR $APP_HOME

COPY --from=BUILD /codenjoy/server/target/$ARTIFACT_NAME .

EXPOSE 8080

ENTRYPOINT java -jar $ARTIFACT_NAME
