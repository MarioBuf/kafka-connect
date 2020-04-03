FROM zookeeper
COPY . /zookeeper/
EXPOSE 2181
CMD ["--name", "zookeeper", "--restart", "always"]

FROM sheepkiller/kafka-manager
COPY . /kafka/
EXPOSE 9092
ENTRYPOINT ["./bin/kafka-manager","-Dconfig.file=conf/application.conf"]

FROM openjdk:8
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} kafka-connect-0.1.jar
EXPOSE 8000
ENTRYPOINT ["java","-jar", "-Duser.timezone=CEST", "/kafka-connect-0.1.jar"]