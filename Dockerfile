FROM openjdk:8
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} kafka-connect-0.1.jar
EXPOSE 8000
ENTRYPOINT ["java","-jar", "-Duser.timezone=CEST", "/kafka-connect-0.1.jar"]