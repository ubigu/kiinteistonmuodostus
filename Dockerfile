FROM openjdk:8u282-jdk AS builder
RUN apt-get update && apt-get install -y git graphviz graphviz-dev fontconfig
RUN git clone -b 'v6.1.0' --depth 1 https://github.com/schemaspy/schemaspy.git
RUN cd schemaspy && ./mvnw package -DskipTests=true

FROM openjdk:8u282-jre-slim

ENV LC_ALL=C

ARG GIT_BRANCH=local
ARG GIT_REVISION=local

ENV MYSQL_VERSION=6.0.6
ENV MARIADB_VERSION=1.1.10
ENV POSTGRESQL_VERSION=42.1.1
ENV JTDS_VERSION=1.3.1

LABEL MYSQL_VERSION=$MYSQL_VERSION
LABEL MARIADB_VERSION=$MARIADB_VERSION
LABEL POSTGRESQL_VERSION=$POSTGRESQL_VERSION
LABEL JTDS_VERSION=$JTDS_VERSION

LABEL GIT_BRANCH=$GIT_BRANCH
LABEL GIT_REVISION=$GIT_REVISION

ADD docker/open-sans.tar.gz /usr/share/fonts/

## Add the wait script to the image
ADD https://github.com/ufoscout/docker-compose-wait/releases/download/2.8.0/wait /wait
RUN chmod +x /wait

RUN adduser java --home / --disabled-password && \
    set -x && \
    apt-get update && apt-get install -y curl unzip graphviz fontconfig && \
    fc-cache -fv && \
    mkdir /drivers_inc && \
    cd /drivers_inc && \
    curl -JLO http://search.maven.org/remotecontent?filepath=mysql/mysql-connector-java/$MYSQL_VERSION/mysql-connector-java-$MYSQL_VERSION.jar && \
    curl -JLO http://search.maven.org/remotecontent?filepath=org/mariadb/jdbc/mariadb-java-client/$MARIADB_VERSION/mariadb-java-client-$MARIADB_VERSION.jar && \
    curl -JLO http://search.maven.org/remotecontent?filepath=org/postgresql/postgresql/$POSTGRESQL_VERSION.jre7/postgresql-$POSTGRESQL_VERSION.jre7.jar && \
    curl -JLO http://search.maven.org/remotecontent?filepath=net/sourceforge/jtds/jtds/$JTDS_VERSION/jtds-$JTDS_VERSION.jar && \
    mkdir /drivers && \
    mkdir /output && \
    chown -R java /drivers_inc && \
    chown -R java /drivers && \
    chown -R java /output

COPY --from=builder /schemaspy/target/schema*.jar /
COPY --from=builder /schemaspy/docker/entrypoint.sh /

USER java
WORKDIR /

VOLUME /drivers /output

CMD /wait && /entrypoint.sh
