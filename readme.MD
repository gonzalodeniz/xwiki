# XWIKI

## Instalación xwiki

Descarga la imagen xwiki

```
docker pull xwiki
```

Prepara el entorno antes de crear los contenedores. Esto solo hay que ejecutarlo la primera vez.

```
./preparacion_entorno.sh
```

### Instalación xwiki usando docker-run

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


### Instalación xwiki usando docker-compose

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

## Apereo / CAS

Se instala si se utiliza el docker-compose para desplegar xwiki.
En el fichero cas-config/resources/application.properties se puede modificar entre otras cosas, los usuarios
por defecto que puede entrar en el CAS.


## Extensiones de XWIKI

Las extensiones se encuentra en "Administer wiki > Extensions"

### LDAP Autheticator

### Authenticator Jasig CAS

 * Copy this authenticator jar file into WEB-INF/lib

PENDIENTE
Descargar el Java Apereo CAS Client y construir el paquete:
https://github.com/apereo/java-cas-client



Download CAS Client for Java 3.1 from http://downloads.jasig.org/cas-clients/cas-client-3.2.1-release.tar.gz and extract cas-client-core-3.2.1.jar and xmlsec-1.3.0.jar into WEB-INF/lib
If you want to use SAML11 protocol you must also download Java OpenSAML 1.1 library from http://shibboleth.net/downloads/java-opensaml/archive/1.1b/opensaml-java-1.1b.tar.gz and extract opensaml-1.1.jar into WEB-INF/lib
Setup xwiki.cfg


## Referencias
- https://xwiki.com/en/Blog/HowtoinstallXWikiusingDocker/
- https://github.com/xwiki-contrib/docker-xwiki/blob/master/README.md
- https://github.com/xwiki-contrib/authenticator-jasig-cas





