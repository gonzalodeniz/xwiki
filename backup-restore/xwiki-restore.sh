#!/bin/bash

# Comprobar si se proporcionó la ruta del backup como argumento
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <backup-directory>"
    exit 1
fi
# Asignar el primer argumento a la variable BACKUP_DIR
BACKUP_DIR=$1

# Docker
XWIKI_DOCKER="xwiki"
POSTGRES_DOCKER="xwiki-postgres"

# PostgreSQL database
DB_NAME="xwiki"
DB_USER="xwiki"
DB_PASSWORD="xwiki"
DB_HOST="localhost"
DB_PORT="5432"

# Detiene el tomcat
TOMCAT_STOP_CMD='/usr/local/tomcat/bin/shutdown.sh'
docker exec -i $XWIKI_DOCKER sh -c "$TOMCAT_STOP_CMD"

# Restaurar la base de datos PostgreSQL
BACKUP_DB=$BACKUP_DIR"/xwiki_db.sql"
PG_RESTORE_CMD="psql -U $DB_USER $DB_NAME"

cat $BACKUP_DB | docker exec -i $POSTGRES_DOCKER $PG_RESTORE_CMD

if [ $? -eq 0 ]; then
    echo "Database restore completed successfully"
else
    echo "Database restore encountered an error"
fi

# Restaurar datos
BACKUP_DATA=$BACKUP_DIR"/xwiki_data.tar.gz"
TAR_DATA_CMD="tar xzf - --overwrite -C /usr/local/"

docker exec -i $XWIKI_DOCKER sh -c "$TAR_DATA_CMD" < $BACKUP_DATA

if [ $? -eq 0 ]; then
    echo "Data restore completed successfully"
else
    echo "Data restore encountered an error"
fi

# Restaurar el contexto de despliegue
XWIKI_WEBAPPS_DIR="/usr/local/tomcat/webapps/"
BACKUP_WAR=$BACKUP_DIR"/aplicaciones_xwiki.tar.gz"
TAR_WAR_CMD="tar xzf - --overwrite -C $XWIKI_WEBAPPS_DIR"

docker exec -i $XWIKI_DOCKER sh -c "$TAR_WAR_CMD" < $BACKUP_WAR

if [ $? -eq 0 ]; then
    echo "WAR restore completed successfully"
else
    echo "WAR restore encountered an error"
fi

# Restaurar Cacerts
CACERTS_DIR="/opt/java/openjdk/lib/security/"
BACKUP_CACERTS=$BACKUP_DIR"/cacerts.tar.gz"
TAR_CACERTS_CMD="tar xzf - --overwrite -C $CACERTS_DIR"

docker exec -i $XWIKI_DOCKER sh -c "$TAR_CACERTS_CMD" < $BACKUP_CACERTS

if [ $? -eq 0 ]; then
    echo "Cacerts restore completed successfully"
else
    echo "Cacerts restore encountered an error"
fi

# Arranca el tomcat
TOMCAT_START_CMD='/usr/local/tomcat/bin/startup.sh'
docker exec -i $XWIKI_DOCKER sh -c "$TOMCAT_START_CMD"
