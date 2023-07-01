FROM amazoncorretto:8-al2023-jre

MAINTAINER ZnPi

RUN mkdir -p /pi/server/logs

WORKDIR /pi/server

ENV SERVER_PORT=9317
ENV POWERJOB_WORKER_PORT=27777

EXPOSE ${SERVER_PORT}

ADD target/pi-boot.jar ./app.jar

ENTRYPOINT ["java", "-Dserver.port=${SERVER_PORT}", "-Dpowerjob.worker.port=${POWERJOB_WORKER_PORT}", "-jar", "app.jar"]