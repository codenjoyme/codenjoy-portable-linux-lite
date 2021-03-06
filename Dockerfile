######################################################
#           Game Server project build
######################################################
FROM maven:3.6.3-openjdk-11 as BUILD
MAINTAINER Igor Petrov

ENV MVN_HOME=/home/maven

# comma-separated list of games or 'allGames'
# TODO for all games sould be -P parameter in 'mvn clean package' command
ENV GAMES=allGames

WORKDIR $MVN_HOME

COPY ./codenjoy/CodingDojo/games ./games
COPY ./codenjoy/CodingDojo/server ./server
COPY ./codenjoy/CodingDojo/balancer ./balancer
COPY ./codenjoy/CodingDojo/utilities ./utilities
COPY ./codenjoy/CodingDojo/pom.xml ./pom.xml

RUN mvn clean package -D$GAMES -DskipTests

######################################################
#                 Game Server image
######################################################
FROM openjdk:11 as SERVER
MAINTAINER Igor Petrov

ENV APP_HOME=/usr/app

ENV ARTIFACT_NAME=codenjoy-contest.war

WORKDIR $APP_HOME

COPY --from=BUILD /home/maven/server/target/$ARTIFACT_NAME .

EXPOSE 8080

ENTRYPOINT java -jar $ARTIFACT_NAME