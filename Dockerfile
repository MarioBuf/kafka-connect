FROM alpine:3.9.2

RUN apk add --update openjdk8-jre supervisor bash

ENV USER root
ENV HOME /root

ENV ZOOKEEPER_VERSION 3.6.0
ENV ZOOKEEPER_HOME /opt/apache-zookeeper-"$ZOOKEEPER_VERSION"-bin

RUN wget -q https://downloads.apache.org/zookeeper/zookeeper-"$ZOOKEEPER_VERSION"/apache-zookeeper-"$ZOOKEEPER_VERSION"-bin.tar.gz -O /tmp/zookeeper.tar.gz
RUN ls -l /tmp/zookeeper.tar.gz
RUN tar xfz /tmp/zookeeper.tar.gz -C /opt/ && rm /tmp/zookeeper.tar.gz && rm $ZOOKEEPER_HOME/conf/zoo_sample.cfg
ADD kafka/config/zoo.cfg $ZOOKEEPER_HOME/conf

ENV SCALA_VERSION 2.12
ENV KAFKA_VERSION 2.4.0
ENV KAFKA_HOME /opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"

RUN wget "https://archive.apache.org/dist/kafka/"$KAFKA_VERSION"/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz" -O /tmp/kafka.tgz
RUN ls -l /tmp/kafka.tgz
RUN tar xfz /tmp/kafka.tgz -C /opt && rm /tmp/kafka.tgz
ADD kafka/config/server.properties $KAFKA_HOME/config

RUN set -x && apk add --no-cache curl
RUN curl -Lo /tmp/ngrok.zip "https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip"
RUN unzip -o /tmp/ngrok.zip -d $HOME && rm -f /tmp/ngrok.zip

ADD kafka/config/ngrok.yml $HOME/.ngrok2/

ADD target/kafka-connect-0.1.jar /opt/bin/kafka-connect-0.1.jar

ADD kafka/starter/start-kafka.sh /usr/bin/start-kafka.sh
ADD kafka/starter/start-zookeeper.sh /usr/bin/start-zookeeper.sh
ADD kafka/starter/start-kafka-connect.sh /usr/bin/start-kafka-connect.sh
ADD kafka/starter/start-ngrok.sh /usr/bin/start-ngrok.sh

ADD kafka/supervisor/zookeeper.ini kafka/supervisor/kafka.ini kafka/supervisor/kafka-connect.ini kafka/supervisor/ngrok.ini /etc/supervisor.d/

COPY entrypoint.sh /

VOLUME /app

EXPOSE 4040

CMD ["/entrypoint.sh"]