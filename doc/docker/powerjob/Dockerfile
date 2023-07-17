FROM tjqq/powerjob-server:latest

ENV PROFILE=daily
ENV MYSQL_HOST=127.0.0.1
ENV MYSQL_PORT=3306
ENV MYSQL_USERNAME=root
ENV MYSQL_PASSWORD=root
ENV TZ="Asia/Shanghai"
ENV PARAMS="--spring.profiles.active=${PROFILE} --spring.datasource.core.jdbc-url=jdbc:mysql://${MYSQL_HOST}:${MYSQL_PORT}/powerjob-${PROFILE}?useUnicode=true&characterEncoding=UTF-8 --spring.datasource.core.username=${MYSQL_USERNAME} --spring.datasource.core.password=${MYSQL_PASSWORD}"
