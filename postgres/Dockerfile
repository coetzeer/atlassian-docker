FROM postgres:9.4
ENV POSTGRES_USER docker
ENV POSTGRES_PASSWORD docker

ADD initdb.sql /docker-entrypoint-initdb.d/initdb.sql
