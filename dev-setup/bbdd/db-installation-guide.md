# Database Installation and Configuration Guide for macOS

This guide will help you install and configure PostgreSQL, MariaDB, MongoDB, and Redis on macOS, along with service management using **DBngin** and recommended database management clients.

## Table of Contents

- [Installation with Homebrew](#installation-with-homebrew)
- [PostgreSQL](#postgresql)
- [MariaDB](#mariadb)
- [MongoDB](#mongodb)
- [Redis](#redis)
- [Service Management with DBngin](#service-management-with-dbngin)
- [Database Management Clients](#database-management-clients)

## Installation with Homebrew

For all installations, we'll use Homebrew as the package manager.

```bash
# Install Homebrew if not already installed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## PostgreSQL

### Installation (version 17.4)

```bash
# Install PostgreSQL
brew install postgresql@17
```

### Configuration

```bash
# Start the service
brew services start postgresql@17

# Add to PATH
echo 'export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"' >> ~/.zshrc

# Create a user and database
psql postgres -c "CREATE USER myuser WITH PASSWORD 'mypassword' SUPERUSER;"
psql postgres -c "CREATE DATABASE mydb_postgresql OWNER myuser;"

# Verify connection
psql -U dmndev -d mydb_postgresql -h localhost
```

### Service Management

```bash
# Start
brew services start postgresql@17

# Stop
brew services stop postgresql@17

# Restart
brew services restart postgresql@17

# Check status
brew services info postgresql@17
```

## MariaDB

### Installation (version 11.7)

```bash
# Install MariaDB
brew install mariadb
```

### Configuration

```bash
# Start the service
brew services start mariadb

# Configure security (run and follow instructions)
sudo mysql_secure_installation

# Create user and database
mysql -u root -p -e "CREATE USER 'myuser'@'localhost' IDENTIFIED BY 'mypassword';"
mysql -u root -p -e "GRANT ALL PRIVILEGES ON *.* TO 'myuser'@'localhost';"
mysql -u root -p -e "CREATE DATABASE mydb_mariadb;"
mysql -u root -p -e "FLUSH PRIVILEGES;"

# Verify connection
mysql -u myuser -p mydb_mariadb
```

### Service Management

```bash
# Start
brew services start mariadb

# Stop
brew services stop mariadb

# Restart
brew services restart mariadb

# Check status
brew services info mariadb
```

## MongoDB

### Installation (version 8.0)

```bash
# Install MongoDB
brew tap mongodb/brew
brew install mongodb-community@8.0
```

### Configuration

```bash
# Start the service
brew services start mongodb/brew/mongodb-community

# Create admin user
mongosh --eval "db = db.getSiblingDB('admin'); db.createUser({ user: 'myuser', pwd: 'mypassword', roles: [ { role: 'userAdminAnyDatabase', db: 'admin' } ] })"

# Create a database and collection
mongosh --eval "db = db.getSiblingDB('mydb_mongodb'); db.createCollection('first_collection')"

# Verify connection with authentication
mongosh --authenticationDatabase admin -u myuser -p mypassword
```

### Service Management

```bash
# Start
brew services start mongodb/brew/mongodb-community

# Stop
brew services stop mongodb/brew/mongodb-community

# Restart
brew services restart mongodb/brew/mongodb-community

# Check status
brew services info mongodb/brew/mongodb-community
```

## Redis

### Installation (version 7.2)

```bash
# Install Redis
brew install redis
```

### Configuration

```bash
# Start the service
brew services start redis

# Configure password (optional)
echo "requirepass mypassword" >> /opt/homebrew/etc/redis.conf
brew services restart redis

# Create test data
redis-cli -a mypassword SET test_key "Hello Redis"

# Verify connection
redis-cli -a mypassword GET test_key
```

### Service Management

```bash
# Start
brew services start redis

# Stop
brew services stop redis

# Restart
brew services restart redis

# Check status
brew services info redis
```

## Service Management with DBngin

DBngin is a graphical application to manage database services on macOS. It facilitates installation, configuration, and service management of PostgreSQL, MySQL/MariaDB, MongoDB, and Redis.

### Installing DBngin

1. Download DBngin from the [official site](https://dbngin.com/)
2. Drag the application to your Applications folder
3. Open DBngin

### Managing PostgreSQL with DBngin

1. Open DBngin
2. Click the "+" button to create a new database
3. Select "PostgreSQL" and version "16.x"
4. Set a name for the instance (e.g., "postgres16")
5. Click "Create"
6. To start/stop the service, use the controls in the graphical interface
7. To access the database:
   - Click "Connect" to see the connection information
   - Default user: postgres (no password)

#### Creating user and database in PostgreSQL with DBngin

```bash
# Use terminal to connect to the instance created by DBngin
psql -h localhost -p [ASSIGNED_PORT] -U postgres

# Inside psql, create user and database
CREATE USER myuser WITH PASSWORD 'mypassword' SUPERUSER;
CREATE DATABASE mydb_postgresql OWNER myuser;
```

### Managing MySQL/MariaDB with DBngin

DBngin doesn't directly support MariaDB, but you can manage MySQL, which is compatible in many aspects:

1. Open DBngin
2. Click the "+" button to create a new database
3. Select "MySQL" and the latest available version
4. Set a name for the instance (e.g., "mysql8")
5. Click "Create"
6. Use the interface controls to start/stop the service
7. To access:
   - Click "Connect" to see the connection information
   - Default user: root (no password)

#### Creating user and database in MySQL with DBngin

```bash
# Use terminal to connect to the instance created by DBngin
mysql -h localhost -P [ASSIGNED_PORT] -u root

# Inside mysql, create user and database
CREATE USER 'myuser'@'localhost' IDENTIFIED BY 'mypassword';
GRANT ALL PRIVILEGES ON *.* TO 'myuser'@'localhost';
CREATE DATABASE mydb_mysql;
FLUSH PRIVILEGES;
```

### Managing MongoDB with DBngin

1. Open DBngin
2. Click the "+" button to create a new database
3. Select "MongoDB" and version "7.x"
4. Set a name for the instance (e.g., "mongodb7")
5. Click "Create"
6. Use the interface controls to start/stop the service
7. To access:
   - Click "Connect" to see the connection information

#### Creating user and database in MongoDB with DBngin

```bash
# Use terminal to connect to the instance created by DBngin
mongosh --host localhost --port [ASSIGNED_PORT]

# Inside mongosh, create admin user
use admin
db.createUser({ user: 'myuser', pwd: 'mypassword', roles: [ { role: 'userAdminAnyDatabase', db: 'admin' } ] })

# Create a database and collection
use mydb_mongodb
db.createCollection('first_collection')
```

### Managing Redis with DBngin

DBngin currently doesn't directly support Redis, so you'll need to use Homebrew services for Redis management.

## Database Management Clients

### PostgreSQL Management Clients

1. **pgAdmin 4**
   - Official PostgreSQL administration tool
   - Features: Visual query builder, schema browser, data export/import
   - Installation: `brew install --cask pgadmin4`

2. **TablePlus**
   - Multi-database manager with a clean interface
   - Features: Visual query editor, data editing, SSH tunneling
   - Installation: `brew install --cask tableplus`

3. **Postico**
   - Mac-native PostgreSQL client
   - Features: Simple interface, table structure browsing, query editor
   - Installation: `brew install --cask postico`

### MariaDB/MySQL Management Clients

1. **TablePlus**
   - Works with both MariaDB and MySQL
   - Features: Data browsing, visual query builder, multiple connection profiles
   - Installation: `brew install --cask tableplus`

2. **Sequel Pro** / **Sequel Ace**
   - Mac-native MySQL/MariaDB client (Sequel Ace is the modern fork)
   - Features: Query editor, data import/export, SSH connections
   - Installation: `brew install --cask sequel-ace`

3. **MySQL Workbench**
   - Official MySQL tool (works with MariaDB with some limitations)
   - Features: Visual schema designer, performance dashboard, user management
   - Installation: `brew install --cask mysqlworkbench`

4. **DBeaver**
   - Universal database client with support for MariaDB and MySQL
   - Features: SQL editor, data transfer, ER diagram viewer
   - Installation: `brew install --cask dbeaver-community`

### MongoDB Management Clients

1. **MongoDB Compass**
   - Official MongoDB GUI
   - Features: Query builder, schema visualization, performance metrics
   - Installation: `brew install --cask mongodb-compass`

2. **Studio 3T**
   - Professional MongoDB manager (free version available)
   - Features: SQL query support, aggregation pipeline editor, data import/export
   - Installation: `brew install --cask studio-3t`

3. **NoSQLBooster**
   - MongoDB GUI with IntelliSense-style query completion
   - Features: Query builder, chart visualization, shell enhancements
   - Installation: `brew install --cask nosqlbooster-for-mongodb`

### Redis Management Clients

1. **RedisInsight**
   - Official Redis GUI client
   - Features: Data browser, CLI, performance monitoring
   - Installation: `brew install --cask redisinsight`

2. **TablePlus**
   - Works well with Redis
   - Features: Data browser, query execution, multiple connection profiles
   - Installation: `brew install --cask tableplus`

3. **Medis**
   - Redis GUI for macOS
   - Features: Clean interface, JSON formatting, bulk operations
   - Installation: `brew install --cask medis`

## Credential Summary

| Database   | User    | Password    | Database         |
|------------|---------|-------------|------------------|
| PostgreSQL | myuser  | mypassword  | mydb_postgresql  |
| MariaDB    | myuser  | mypassword  | mydb_mariadb     |
| MongoDB    | myuser  | mypassword  | mydb_mongodb     |
| Redis      | N/A     | mypassword  | N/A (uses db number) |

---

With this configuration, you'll have a complete development environment with all four databases running on your Mac, with services managed by both Homebrew Services and DBngin (where supported), and suitable client applications for each database system.
