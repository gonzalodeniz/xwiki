# XWIKI

## Instalación

Descarga la imagen xwiki

```
docker pull xwiki
```

Prepara el entorno antes de crear los contenedores. Esto solo hay que ejecutarlo la primera vez.

```
./preparacion_entorno.sh
```

### Instalación usando docker-run

Crea una red dedicada para xwiki

```
docker network create -d bridge xwiki-nw
```

Lanza el contenedor de mysql

```
./run_mysql_xwiki.sh
```

Crea el contenedor para xwiki

```
./run_xwiki.sh
```

Comprueba si se ejecuta correctamente (xwiki.mv es un nombre local de dns que apunta a la máquina donde está instalado xwiki)

 http://localhost:8080/bin/view/Main
 http://xwiki.mv:8080/bin/view/Main


Si quieres conetarte a la base de datos Mysql

```
docker exec -it mysql-xwiki bash
mysql -uxwiki -pxwiki
```


### Instalación usando docker-compose

Antes de lanzar docker-compose compruebas que haz creado las carpetas con el script "preparacion_entorno.sh".

Lanza el docker-compose

```
docker-compose up -d
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

En la segundo paso instala Flavor que viene por defecto.

## Referencias
- https://xwiki.com/en/Blog/HowtoinstallXWikiusingDocker/
- https://github.com/xwiki-contrib/docker-xwiki/blob/master/README.md



