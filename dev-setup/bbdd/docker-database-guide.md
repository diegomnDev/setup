# Docker Database Setup Guide

This guide covers setting up PostgreSQL, MariaDB, MongoDB, and Redis with Docker, including Dockerfile examples, Docker Compose configurations, and management through CLI, Docker Desktop, and OrbStack.

## Table of Contents

- [Installation](#installation)
  - [Docker Desktop](#docker-desktop)
  - [OrbStack](#orbstack)
- [Database Docker Configurations](#database-docker-configurations)
  - [PostgreSQL](#postgresql)
  - [MariaDB](#mariadb)
  - [MongoDB](#mongodb)
  - [Redis](#redis)
- [Docker Compose Setup](#docker-compose-setup)
- [Management Commands](#management-commands)
- [Using Docker Desktop](#using-docker-desktop)
- [Using OrbStack](#using-orbstack)

## Installation

### Docker Desktop

1. Download Docker Desktop from the [official website](https://www.docker.com/products/docker-desktop/)
2. Install the application
3. Start Docker Desktop
4. Verify installation:

   ```bash
   docker --version
   docker-compose --version
   ```

### OrbStack

1. Download OrbStack from the [official website](https://orbstack.dev/)
2. Install the application
3. Start OrbStack
4. Verify installation:

   ```bash
   docker --version
   docker-compose --version
   ```

### Database Docker Configurations

### PostgreSQL

#### Dockerfile for PostgreSQL

```dockerfile
FROM postgres:17

ENV POSTGRES_USER=myuser
ENV POSTGRES_PASSWORD=mypassword
ENV POSTGRES_DB=mydb_postgresql

# Custom initialization scripts
COPY ./postgres-init.sql /docker-entrypoint-initdb.d/

EXPOSE 5432
```

#### postgres-init.sql

```sql
-- Create additional database objects if needed
CREATE TABLE IF NOT EXISTS test_table (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO test_table (name) VALUES ('Initial test data');
```

#### Build and Run with Docker CLI

```bash
# Build the custom PostgreSQL image
docker build -t custom-postgres .

# Run the custom PostgreSQL container
docker run -d \
  --name postgres-db-custom \
  -p 5432:5432 \
  -v postgres_data:/var/lib/postgresql/data \
  custom-postgres
```

#### Run Official Image Directly

```bash
# Run PostgreSQL container with official image
docker run -d \
  --name postgres-db \
  -e POSTGRES_USER=myuser \
  -e POSTGRES_PASSWORD=mypassword \
  -e POSTGRES_DB=mydb_postgresql \
  -p 5432:5432 \
  -v postgres_data:/var/lib/postgresql/data \
  postgres:17
```

#### Connect to PostgreSQL

```bash
# Connect to custom image container
docker exec -it postgres-db-custom psql -U myuser -d mydb_postgresql

# Connect to official image container
docker exec -it postgres-db psql -U myuser -d mydb_postgresql

# Connect from host machine
psql -h localhost -U myuser -d mydb_postgresql
```

#### Connect from External Tools (DBeaver, etc.)

To connect from any external database client (such as DBeaver, pgAdmin, or TablePlus), use the following connection parameters:

```code
Host: localhost (or your machine's IP address)
Port: 5432
Database: mydb_postgresql
Username: myuser
Password: mypassword
```

#### View Container Logs

```bash
# View logs for custom container
docker logs postgres-db-custom

# View logs for official image container
docker logs postgres-db
```

#### Stop Container

```bash
# Stop custom container
docker stop postgres-db-custom

# Stop official image container
docker stop postgres-db
```

#### Remove Container

```bash
# Remove custom container (must be stopped first)
docker rm postgres-db-custom

# Remove official image container (must be stopped first)
docker rm postgres-db

# Force remove a running container
docker rm -f postgres-db
```

### MariaDB

#### Dockerfile for MariaDB

```dockerfile
FROM mariadb:11

ENV MARIADB_ROOT_PASSWORD=myrootpassword
ENV MARIADB_USER=myuser
ENV MARIADB_PASSWORD=mypassword
ENV MARIADB_DATABASE=mydb_mariadb

# Custom initialization scripts
COPY ./mariadb-init.sql /docker-entrypoint-initdb.d/

EXPOSE 3306
```

#### mariadb-init.sql

```sql
-- Create additional database objects if needed
CREATE TABLE IF NOT EXISTS test_table (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO test_table (name) VALUES ('Initial test data');
```

#### Build and Run with Docker CLI

```bash
# Build the custom MariaDB image
docker build -t custom-mariadb .

# Run the custom MariaDB container
docker run -d \
  --name mariadb-db-custom \
  -p 3306:3306 \
  -v mariadb_data:/var/lib/mysql \
  custom-mariadb
```

#### Run Official Image Directly

```bash
# Run MariaDB container with official image
docker run -d \
  --name mariadb-db \
  -e MARIADB_USER=myuser \
  -e MARIADB_PASSWORD=mypassword \
  -e MARIADB_DATABASE=mydb_mariadb \
  -p 3306:3306 \
  -v mariadb_data:/var/lib/mysql \
  mariadb:11
```

#### Connect to MariaDB

```bash
# Connect to custom image container
docker exec -it mariadb-db-custom mariadb -u myuser -pmypassword mydb_mariadb

# Connect to official image container
docker exec -it mariadb-db mariadb -u myuser -pmypassword mydb_mariadb

# Connect from host machine
mysql -h 127.0.0.1 -P 3306 -u myuser -pmypassword mydb_mariadb
```

#### Connect from External Tools (MySQL Workbench, etc.)

To connect from any external database client (such as MySQL Workbench, DBeaver, or HeidiSQL), use the following connection parameters:

```code
Host: localhost (or your machine's IP address)
Port: 3306
Database: mydb_mariadb
Username: myuser
Password: mypassword
```

#### View Container Logs

```bash
# View logs for custom container
docker logs mariadb-db-custom

# View logs for official image container
docker logs mariadb-db
```

#### Stop Container

```bash
# Stop custom container
docker stop mariadb-db-custom

# Stop official image container
docker stop mariadb-db
```

#### Remove Container

```bash
# Remove custom container (must be stopped first)
docker rm mariadb-db-custom

# Remove official image container (must be stopped first)
docker rm mariadb-db

# Force remove a running container
docker rm -f mariadb-db
```

### MongoDB

#### Dockerfile for MongoDB

```dockerfile
FROM mongo:7

ENV MONGO_INITDB_ROOT_USERNAME=myuser
ENV MONGO_INITDB_ROOT_PASSWORD=mypassword
ENV MONGO_INITDB_DATABASE=mydb_mongodb

# Add initialization script
COPY ./mongo-init.js /docker-entrypoint-initdb.d/

EXPOSE 27017
```

#### mongo-init.js

```javascript
// Switch to the application database
db = db.getSiblingDB('mydb_mongodb');

// Create a collection
db.createCollection('first_collection');

// Insert sample data
db.first_collection.insertOne({
    name: "Initial test data",
    created_at: new Date()
});

// Grant specific permissions to the root user for this database
db = db.getSiblingDB("admin");
db.grantRolesToUser("myuser", [{ role: "readWrite", db: "mydb_mongodb" }]);

// Optionally create an application-specific user
// db = db.getSiblingDB('mydb_mongodb');
// db.createUser({
//     user: 'appuser',
//     pwd: 'apppassword',
//     roles: [{ role: 'readWrite', db: 'mydb_mongodb' }]
// });
```

#### Build and Run with Docker CLI

```bash
# Build the custom MongoDB image
docker build -t custom-mongodb .

# Run the custom MongoDB container
docker run -d \
  --name mongodb-db-custom \
  -p 27017:27017 \
  -v mongodb_data:/data/db \
  custom-mongodb
```

#### Run Official Image Directly

```bash
# Run MongoDB container with official image
docker run -d \
  --name mongodb-db \
  -e MONGO_INITDB_ROOT_USERNAME=myuser \
  -e MONGO_INITDB_ROOT_PASSWORD=mypassword \
  -e MONGO_INITDB_DATABASE=mydb_mongodb \
  -p 27017:27017 \
  -v mongodb_data:/data/db \
  mongo:7
```

#### Connect to MongoDB

```bash
# Connect with root user to the specific database
docker exec -it mongodb-db-custom mongosh -u myuser -p mypassword --authenticationDatabase admin mydb_mongodb

# Alternative connection format (specifies database in connection string)
docker exec -it mongodb-db-custom mongosh "mongodb://myuser:mypassword@localhost:27017/mydb_mongodb?authSource=admin"

# Connect to official image container
docker exec -it mongodb-db mongosh -u myuser -p mypassword --authenticationDatabase admin mydb_mongodb

# Connect from host machine
mongosh -u myuser -p mypassword --authenticationDatabase admin --host localhost --port 27017 mydb_mongodb
```

#### Connect from External Tools (MongoDB Compass, etc.)

To connect from any external MongoDB client (such as MongoDB Compass, Studio 3T, or other tools), use the following connection string:

```
mongodb://myuser:mypassword@localhost:27017/mydb_mongodb?authSource=admin
```

Note that `authSource=admin` is required when using the root user created by the Dockerfile.

Or individual parameters:

```
Host: localhost (or your machine's IP address)
Port: 27017
Authentication: Username/Password
Username: myuser
Password: mypassword
Authentication Database: admin
Database: mydb_mongodb
```

#### View Container Logs

```bash
# View logs for custom container
docker logs mongodb-db-custom

# View logs for official image container
docker logs mongodb-db
```

#### Stop Container

```bash
# Stop custom container
docker stop mongodb-db-custom

# Stop official image container
docker stop mongodb-db
```

#### Remove Container

```bash
# Remove custom container (must be stopped first)
docker rm mongodb-db-custom

# Remove official image container (must be stopped first)
docker rm mongodb-db

# Force remove a running container
docker rm -f mongodb-db
```

### Redis

#### Dockerfile for Redis

```dockerfile
FROM redis:7.4

# Copy custom Redis configuration
COPY ./redis.conf /usr/local/etc/redis/redis.conf

# Run Redis with the custom configuration
CMD ["redis-server", "/usr/local/etc/redis/redis.conf"]

EXPOSE 6379
```

#### redis.conf

```
# Basic Redis configuration file
# Set password
requirepass mypassword

# Save to disk every 60 seconds if at least 1 key changed
save 60 1

# Filename for the append only file
appendonly yes
appendfilename "appendonly.aof"
```

#### Build and Run with Docker CLI

```bash
# Build the custom Redis image
docker build -t custom-redis .

# Run the custom Redis container
docker run -d \
  --name redis-db-custom \
  -p 6379:6379 \
  -v redis_data_custom:/data \
  custom-redis
```

#### Run Official Image Directly

```bash
# Run Redis container with official image
docker run -d \
  --name redis-db \
  -p 6379:6379 \
  -v redis_data:/data \
  redis:7.4 \
  redis-server --requirepass mypassword
```

#### Connect to Redis

```bash
# Connect to custom image container
docker exec -it redis-db-custom redis-cli -a mypassword

# Connect to official image container
docker exec -it redis-db redis-cli -a mypassword

# Alternative: Connect without password in command (more secure)
docker exec -it redis-db redis-cli
# Then authenticate inside the CLI
> AUTH mypassword

# Connect from host machine
redis-cli -h localhost -p 6379 -a mypassword
```

#### Connect from External Tools

To connect from any external Redis client (such as RedisInsight, Another Redis Desktop Manager, or other tools), use the following connection parameters:

```
Host: localhost (or your machine's IP address)
Port: 6379
Password: mypassword
```

#### Test Redis Connection

Once connected, you can verify the Redis connection with these commands:

```
# Ping to test connection
PING

# Set a test key
SET testkey "Hello Redis"

# Get the test key
GET testkey

# Check server info
INFO

# List all keys
KEYS *
```

#### View Container Logs

```bash
# View logs for custom container
docker logs redis-db-custom

# View logs for official image container
docker logs redis-db
```

#### Stop Container

```bash
# Stop custom container
docker stop redis-db-custom

# Stop official image container
docker stop redis-db
```

#### Remove Container

```bash
# Remove custom container (must be stopped first)
docker rm redis-db-custom

# Remove official image container (must be stopped first)
docker rm redis-db

# Force remove a running container
docker rm -f redis-db
```

## Docker Compose Setup

Create a `docker-compose.yml` file to run all databases together:

```yaml
version: '3.8'

services:
  postgres:
    image: postgres:17
    container_name: postgres-db
    environment:
      POSTGRES_USER: myuser
      POSTGRES_PASSWORD: mypassword
      POSTGRES_DB: mydb_postgresql
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
      - ./postgres-init.sql:/docker-entrypoint-initdb.d/postgres-init.sql
    restart: unless-stopped

  mariadb:
    image: mariadb:11
    container_name: mariadb-db
    environment:
      MARIADB_ROOT_PASSWORD: myrootpassword
      MARIADB_USER: myuser
      MARIADB_PASSWORD: mypassword
      MARIADB_DATABASE: mydb_mariadb
    ports:
      - "3306:3306"
    volumes:
      - mariadb_data:/var/lib/mysql
      - ./mariadb-init.sql:/docker-entrypoint-initdb.d/mariadb-init.sql
    restart: unless-stopped

  mongodb:
    image: mongo:7
    container_name: mongodb-db
    environment:
      MONGO_INITDB_ROOT_USERNAME: myuser
      MONGO_INITDB_ROOT_PASSWORD: mypassword
      MONGO_INITDB_DATABASE: mydb_mongodb
    ports:
      - "27017:27017"
    volumes:
      - mongodb_data:/data/db
      - ./mongo-init.js:/docker-entrypoint-initdb.d/mongo-init.js
    restart: unless-stopped

  redis:
    image: redis:7.4
    container_name: redis-db
    command: redis-server --requirepass mypassword
    ports:
      - "6379:6379"
    volumes:
      - redis_data:/data
    restart: unless-stopped

volumes:
  postgres_data:
  mariadb_data:
  mongodb_data:
  redis_data:
```

## Management Commands

### Docker CLI Commands

**Start all services with Docker Compose:**

```bash
docker-compose up -d
```

**Stop all services:**

```bash
docker-compose down
```

**Check running containers:**

```bash
docker ps
```

**View container logs:**

```bash
docker logs postgres-db
docker logs mariadb-db
docker logs mongodb-db
docker logs redis-db
```

**Start an individual container:**

```bash
docker start postgres-db
```

**Stop an individual container:**

```bash
docker stop postgres-db
```

**Restart an individual container:**

```bash
docker restart postgres-db
```

**Update an individual container (pull latest image and recreate):**

```bash
# Pull latest image
docker pull postgres:16

# Stop and remove current container
docker stop postgres-db
docker rm postgres-db

# Run new container with same settings (see individual run commands above)
```

**Update all services with Docker Compose:**

```bash
docker-compose pull   # Pull latest images
docker-compose up -d  # Recreate containers if image changed
```

**Check container health:**

```bash
docker inspect --format='{{.State.Health.Status}}' postgres-db
```

**Run command inside container:**

```bash
docker exec -it postgres-db bash
```

**Copy files to/from container:**

```bash
docker cp ./local-file.sql postgres-db:/tmp/
docker cp postgres-db:/var/lib/postgresql/data/postgresql.conf ./
```

**Backup database:**

```bash
# PostgreSQL
docker exec -it postgres-db pg_dump -U myuser mydb_postgresql > postgres_backup.sql

# MariaDB
docker exec -it mariadb-db mysqldump -u myuser -pmypassword mydb_mariadb > mariadb_backup.sql

# MongoDB
docker exec -it mongodb-db mongodump --host localhost --port 27017 -u myuser -p mypassword --authenticationDatabase admin --db mydb_mongodb --out /tmp/mongodump
docker cp mongodb-db:/tmp/mongodump ./mongodb_backup

# Redis
docker exec -it redis-db redis-cli -a mypassword SAVE
docker cp redis-db:/data/dump.rdb ./redis_backup.rdb
```

## Using Docker Desktop

Docker Desktop provides a graphical interface for managing containers:

1. **Start Docker Desktop** application

2. **View running containers:**
   - Go to the "Containers" tab
   - See all running containers with their status

3. **Start/Stop/Restart containers:**
   - Click on the container row
   - Use the play/stop/restart buttons in the interface

4. **View container logs:**
   - Click on a container name
   - Go to the "Logs" tab

5. **Access container shell:**
   - Click on a container name
   - Go to the "Exec" tab
   - Open a terminal session

6. **View container details:**
   - Click on a container name
   - See all environment variables, ports, volumes, etc.

7. **Manage volumes:**
   - Go to the "Volumes" tab
   - Create, delete, or inspect volumes

8. **Manage images:**
   - Go to the "Images" tab
   - Pull, delete, or inspect images

9. **Docker Compose management:**
   - Go to the "Compose" tab
   - Start/stop services defined in docker-compose.yml

10. **Resource usage monitoring:**
    - Go to the "Resources" section in settings
    - Monitor CPU, memory, disk usage

## Using OrbStack

OrbStack provides a lightweight alternative to Docker Desktop:

1. **Start OrbStack** application

2. **View running containers:**
   - See all containers in the main interface
   - Container status is clearly displayed

3. **Start/Stop/Restart containers:**
   - Use the controls next to each container
   - Right-click for more options

4. **View container logs:**
   - Click on a container
   - See logs in the container detail view

5. **Access container shell:**
   - Click on the "Terminal" button for a container

6. **View container details:**
   - Click on a container
   - See mounted volumes, ports, environment variables

7. **Manage volumes:**
   - Go to the "Volumes" section
   - Create, delete, or inspect volumes

8. **Manage images:**
   - Go to the "Images" section
   - Pull, delete, or inspect images

9. **Port management:**
   - See all port bindings
   - Click to quickly open the corresponding port in browser

10. **Resource usage monitoring:**
    - OrbStack is designed to be lightweight
    - Resource usage is displayed in the "Overview" tab

## Credential Summary

| Database   | User    | Password    | Database         | Port  |
|------------|---------|-------------|------------------|-------|
| PostgreSQL | myuser  | mypassword  | mydb_postgresql  | 5432  |
| MariaDB    | myuser  | mypassword  | mydb_mariadb     | 3306  |
| MongoDB    | myuser  | mypassword  | mydb_mongodb     | 27017 |
| Redis      | N/A     | mypassword  | N/A (db 0-15)    | 6379  |
