FROM postgres:latest

ENV POSTGRES_USER=myuser
ENV POSTGRES_PASSWORD=mypassword
ENV POSTGRES_DB=mydb_postgresql

# Custom initialization scripts
COPY ./mariadb-init.sql /docker-entrypoint-initdb.d/

EXPOSE 5432