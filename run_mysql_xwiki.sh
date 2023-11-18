#!/bin/bash

# Configuración de Docker para MySQL con XWiki
CONTAINER_NAME="mysql-xwiki"
NETWORK_NAME="xwiki-nw"
VOLUME_PATH_MYSQL="./mysql"
VOLUME_PATH_INIT="./mysql-init"
MYSQL_ROOT_PASSWORD="xwiki"
MYSQL_USER="xwiki"
MYSQL_PASSWORD="xwiki"
MYSQL_DATABASE="xwiki"
MYSQL_IMAGE_TAG="mysql:5.7"

# Ejecutar el contenedor Docker
docker run --net=$NETWORK_NAME \
           --name $CONTAINER_NAME \
           -v $VOLUME_PATH_MYSQL:/var/lib/mysql \
           -v $VOLUME_PATH_INIT:/docker-entrypoint-initdb.d \
           -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD \
           -e MYSQL_USER=$MYSQL_USER \
           -e MYSQL_PASSWORD=$MYSQL_PASSWORD \
           -e MYSQL_DATABASE=$MYSQL_DATABASE \
           -d $MYSQL_IMAGE_TAG \
           --character-set-server=utf8 \
           --collation-server=utf8_bin \
           --explicit-defaults-for-timestamp=1
