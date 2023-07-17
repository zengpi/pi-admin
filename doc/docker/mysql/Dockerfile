FROM mysql:8.0.33

ADD ./mysql/init/init.sql /docker-entrypoint-initdb.d/init.sql
RUN chown -R mysql:mysql /docker-entrypoint-initdb.d/init.sql

ENV TZ="Asia/Shanghai"

EXPOSE 3306

CMD ["mysqld", "--character-set-server=utf8mb4", "--collation-server=utf8mb4_unicode_ci"]