#!/bin/bash

# Configuración de Docker para XWiki
CONTAINER_NAME="xwiki"
NETWORK_NAME="xwiki-nw"
PORT_MAPPING="8080:8080"
VOLUME_PATH_XWIKI="./data_xwiki"
DB_USER="xwiki"
DB_PASSWORD="xwiki"
DB_DATABASE="xwiki"
DB_HOST="mysql-xwiki"
XWIKI_IMAGE_TAG="xwiki:lts-mysql-tomcat"

# Ejecutar el contenedor Docker
docker run --net=$NETWORK_NAME \
           --name $CONTAINER_NAME \
           -p $PORT_MAPPING \
           -v $VOLUME_PATH_XWIKI:/usr/local/xwiki \
           -e DB_USER=$DB_USER \
           -e DB_PASSWORD=$DB_PASSWORD \
           -e DB_DATABASE=$DB_DATABASE \
           -e DB_HOST=$DB_HOST \
           -d $XWIKI_IMAGE_TAG
