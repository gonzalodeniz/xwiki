#!/bin/bash

# XWiki Hosts
XWIKI_DOCKER="xwiki"
POSTGRES_DOCKER="xwiki-postgres"

# PostgreSQL database details
DB_NAME="xwiki"
DB_USER="xwiki"  
DB_PASSWORD="xwiki" 
DB_HOST="localhost"  
DB_PORT="5432"  

# Directorios
XWIKI_WAR_DIR="/usr/local/tomcat/webapps/aplicaciones#ciberwiki"
BACKUP_DIR="/tmp/backup"  

# Date format for backup filename
DATE=$(date +"%Y%m%d_%H%M%S")

# Backup PostgreSQL database
export PGPASSWORD=$DB_PASSWORD
PG_DUMP_CMD="pg_dump -c -U $DB_USER $DB_NAME" 
docker exec -i $POSTGRES_DOCKER $PG_DUMP_CMD > $BACKUP_DIR/xwiki_db_$DATE.sql



# Backup XWiki WAR directory
# tar -czf $BACKUP_DIR/xwiki_war_$DATE.tar.gz -C $XWIKI_WAR_DIR .
