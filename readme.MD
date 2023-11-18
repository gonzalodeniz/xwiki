# XWIKI

## Instalación

Descarga la imagen xwiki

```
docker pull xwiki
```

Crea una red dedicada para xwiki

```
docker network create -d bridge xwiki-nw
```

### MySQL

Crea las carpetas para mysql y el  fichero init.sql para preparar la base de datos

```
mkdir mysql-init
mkdir mysql
echo "grant all privileges on *.* to xwiki@'%' identified by 'xwiki'" > mysql-init/init.sql
```

Copia el siguiente comando en un fichero **1_run_mysql_xwiki.sh**

```
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

```

Explicación de los parámetros:

- xwiki-nw is the network bridge created at step 1
- mysql-xwiki is the name of the database docker container
- /my/path/mysql is the local folder where docker will store the database data
- /my/path/mysql-init is the local folder to store the file init.sql (the folder - needs to be on your filesystem, you can use any name for either folder or file)
- The MySQL image v5.7 is pulled from Docker Hub
- MYSQL_DATABASE specifies the name of the database for XWiki.


Da permiso de ejecución al fichero y ejecuta el script

```
chmod 755 1_run_mysql_xwiki.sh
./1_run_mysql_xwiki.sh
```

### xwiki
Crea el contenedor para xwiki

Crea la carpeta para los datos de la xwiki

```
mkdir data_xwiki
```
Copia el siguiente comando en un fichero **2_run_xwiki.sh**

```
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

```
Explicación de los parámetros:

* xwiki-nw is the network bridge created at step 1,
* xwiki is the name of the XWiki docker container, 
* -p 8080:8080 exposes the container's 8080 port to the host 8080 (-p hostPort:containerPort),
* for -v ./data_xwiki:/usr/local/xwiki, the path /./data_xwiki represents the local folder where docker will store configuration files and dynamic data for XWiki, while /usr/local/xwiki represents the path to store data inside the container,
* DB_HOST is the name of the container holding the database created at step 2.


Da permiso de ejecución al fichero y ejecuta el script

```
chmod 755 2_run_xwiki.sh
./2_run_xwiki.sh
```

Comprueba si se ejecuta correctamente (xwiki.mv es un nombre local de dns que apunta a la máquina donde está instalado xwiki)

 http://localhost:8080/bin/view/Main
 http://xwiki.mv:8080/bin/view/Main


Si quieres conetarte a la base de datos Mysql

```
docker exec -it mysql-xwiki bash
mysql -uxwiki -pxwiki
```

### Configuración inicial de xwiki

Introduce los datos del usuario admin:

```
First Name: gdeniz
Last Name:
Username: gdeniz
Password: 1q2w3e4R.
Email: gdeniz@inerza.com
```




## Referencias
- https://xwiki.com/en/Blog/HowtoinstallXWikiusingDocker/
- https://github.com/xwiki-contrib/docker-xwiki/blob/master/README.md



