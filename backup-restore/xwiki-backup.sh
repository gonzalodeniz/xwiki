#!/bin/bash

# Fecha y hora
DATE=$(date +"%Y%m%d_%H%M%S")

# Docker
XWIKI_DOCKER="xwiki"
POSTGRES_DOCKER="xwiki-postgres"

# PostgreSQL database
DB_NAME="xwiki"
DB_USER="xwiki"  
DB_PASSWORD="xwiki" 
DB_HOST="localhost"  
DB_PORT="5432"  

# Directorio destino
BACKUP_DIR="/tmp/xwiki_backup/"$DATE  
mkdir -p $BACKUP_DIR

# Backup PostgreSQL database
BACKUP_DB=$BACKUP_DIR"/xwiki_db.sql"
PG_DUMP_CMD="pg_dump -c -U $DB_USER $DB_NAME" 

docker exec -i $POSTGRES_DOCKER $PG_DUMP_CMD > $BACKUP_DB

if [ -s "$BACKUP_DB" ]; then
    echo "Backup BBDD completed successfully"
else
    echo "Backup BBDD encountered an error"
fi

# Backup Data
BACKUP_DATA=$BACKUP_DIR"/xwiki_data.tar.gz"
TAR_DATA_CMD="tar czf - -C /usr/local/ xwiki"

docker exec -i $XWIKI_DOCKER $TAR_DATA_CMD > $BACKUP_DATA

if [ -s "$BACKUP_DATA" ]; then
    echo "Backup Data completed successfully"
else
    echo "Backup Data encountered an error"
fi

# Backup Deploy Context
XWIKI_WEBAPPS_DIR="/usr/local/tomcat/webapps/"
XWIKI_CONTEXT="aplicaciones#ciberwiki"
BACKUP_WAR=$BACKUP_DIR"/aplicaciones_xwiki.tar.gz"
TAR_WAR_CMD="tar czf - -C $XWIKI_WEBAPPS_DIR $XWIKI_CONTEXT"

docker exec -i $XWIKI_DOCKER $TAR_WAR_CMD > $BACKUP_WAR

if [ -s "$BACKUP_WAR" ]; then
    echo "Backup WAR completed successfully"
else
    echo "Backup WAR encountered an error"
fi

# Backup Cacerts
CACERTS_DIR="/opt/java/openjdk/lib/security/"
CACERTS_FILE="cacerts"
BACKUP_CACERTS=$BACKUP_DIR"/cacerts.tar.gz"
TAR_CACERTS_CMD="tar czf - -C $CACERTS_DIR $CACERTS_FILE"

docker exec -i $XWIKI_DOCKER $TAR_CACERTS_CMD > $BACKUP_CACERTS

if [ -s "$BACKUP_CACERTS" ]; then
    echo "Backup Cacerts completed successfully"
else
    echo "Backup Cacerts encountered an error"
fi
