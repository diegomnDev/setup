FROM mongo:latest

ENV MONGO_INITDB_ROOT_USERNAME=myuser
ENV MONGO_INITDB_ROOT_PASSWORD=mypassword
ENV MONGO_INITDB_DATABASE=mydb_mongodb

# Add initialization script
COPY ./mongo-init.js /docker-entrypoint-initdb.d/

EXPOSE 27017