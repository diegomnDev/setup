FROM mariadb:latest

ENV MARIADB_ROOT_PASSWORD=myrootpassword
ENV MARIADB_USER=myuser
ENV MARIADB_PASSWORD=mypassword
ENV MARIADB_DATABASE=mydb_mariadb

# Custom initialization scripts
COPY ./mariadb-init.sql /docker-entrypoint-initdb.d/

EXPOSE 3306
