# XWIKI

## Introducción

XWiki es una plataforma de software libre y de código abierto para la creación de wikis empresariales y aplicaciones colaborativas. Basado en el lenguaje de programación Java y el framework Apache Velocity para plantillas, XWiki permite a los usuarios crear, editar y organizar contenido en un formato similar a un wiki. 
Lo que distingue a XWiki de otros sistemas de gestión de contenido wiki es su modelo de datos estructurado, que facilita la creación de aplicaciones personalizadas dentro del wiki, incluyendo gestores de tareas, CRM, intranets, y más. Además, XWiki soporta una amplia gama de funciones de colaboración y de gestión de documentos, como control de versiones, poderosas capacidades de búsqueda, y una arquitectura extensible a través de complementos. 
Su enfoque modular y flexible lo hace adecuado tanto para pequeñas organizaciones como para grandes empresas que buscan una solución colaborativa integrada.

### Alcance

Este documento es una guía para la instalación de XWiki y su configuración con un procedimiento de autenticación CAS/Single Sign-On en un entorno dockerizado. 

### Requisitos HW y SW

Para desplegar XWiki usando Docker, necesitarás cumplir con ciertos requisitos tanto de software como de hardware. A continuación, detallo estos requisitos:

#### Requisitos de Software

- **Docker**: Debes tener Docker instalado en tu sistema. Docker es una plataforma de contenedores que permite empaquetar aplicaciones y sus dependencias en un contenedor virtualizado, lo cual facilita el despliegue y la escalabilidad. Asegúrate de que tu versión de Docker esté actualizada.
- **Docker Compose**: Docker Compose simplifica el proceso de manejo de múltiples contenedores (por ejemplo, XWiki y una base de datos separada como MySQL o PostgreSQL).
- **Sistema Operativo**: Cualquier sistema operativo compatible con Docker puede utilizarse, incluyendo distribuciones de Linux, macOS y Windows.


#### Requisitos de Hardware

Los requisitos de hardware pueden variar dependiendo del uso y la cantidad de usuarios que se espera que accedan a XWiki. A continuación, se presentan algunas recomendaciones generales:

- **CPU**: Mínimo 2 cores. Para un mejor rendimiento, especialmente en entornos con muchos usuarios, se recomienda una CPU más potente.
Memoria RAM: Mínimo 2 GB de RAM. Para entornos de producción o con un número significativo de usuarios, se recomiendan 4 GB o más.
- **Espacio en Disco**: El requisito de espacio en disco dependerá del volumen de datos y archivos que se esperan almacenar en XWiki. Un mínimo de 10 GB es un buen punto de partida, pero para un uso a largo plazo y con mayor cantidad de datos, considera asignar más espacio.
- **Red**: Asegúrate de tener una conexión de red estable y considera las necesidades de ancho de banda, especialmente si XWiki será accesible públicamente o a través de una red grande.

Es importante recordar que estos requisitos pueden variar en función de las necesidades específicas y el tamaño de tu implementación de XWiki. Para entornos de producción a gran escala, es recomendable realizar pruebas de rendimiento y considerar la escalabilidad de los recursos según sea necesario.

## Procedimiento de instalación

### Preparación del sistema

Actualiza el sistema  

    sudo yum -y update

Instalación de docker

    sudo yum install -y yum-utils device-mapper-persistent-data lvm2
    sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    sudo yum install docker-ce docker-ce-cli containerd.io
    sudo systemctl start docker
    sudo systemctl enable docker

Instalción de docker-compose

    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

    sudo chmod +x /usr/local/bin/docker-compose
    docker-compose --version

Descarga y descomprime las carpetas y ficheros de instalación xwiki en tu servidor.

### Certificados

Genera los certificados que se van a utilizar en el apache y en el cas, sustituyendo el nombre del dominio por el correspondiente. 
Sustituye el ficher server.crt generado por los que se encuentra en la carpeta build-httpd/

Certificado del servidor xwiki

    cd build-httpd

    openssl req -x509 -newkey rsa:2048 -keyout server.key -out server.crt -days 365 -nodes -subj "/CN=xwiki.mv" -addext "subjectAltName=DNS:xwiki.mv,DNS:xwiki,DNS:192.168.56.101"

Sustituye el fichero cas.crt generado por el que se encuentra en la carpeta cas-config.
Certificado del CAS

    cd cas-config

    openssl req -x509 -newkey rsa:2048 -keyout cas.key -out cas.crt -days 365 -nodes -subj "/CN=cas" -addext "subjectAltName=DNS:cas,DNS:192.168.56.101"

### Instalación xwiki

Se da por hecho que tienes instalado los ficheros de este repositorio en un directorio de tu sistema linux. Modifica los siguientes ficheros si fuera necesario para adaptarlo a tu infraestructura. 

#### Fichero de configuración de apache build-httpd/httpd.conf

Aquí en un principio no hay que modificar nada si las rutas de contexto son **aplicaciones/xwiki**

    vim build-httpd/httpd.conf


    ########################################################
    # Configuracion HTTP a HTTPS
    ########################################################
    <VirtualHost *:80>
    RewriteEngine On
    RewriteCond %{HTTPS} off
    RewriteRule ^/?(.*) https://%{SERVER_NAME}/$1 [R,L]
    </VirtualHost>


    ########################################################
    # Configuracion PROXY REVERSE HTTPS
    ########################################################
    Listen 443
    <VirtualHost *:443>
        LogLevel debug

        # Certificado
        SSLEngine on
        
        # Desactiva toda verificacion
        SSLProxyEngine on

        SSLCertificateFile "conf/server.crt"
        SSLCertificateKeyFile "conf/server.key"

        RewriteEngine on
        # Inserta la barra final si no se pone
        RewriteRule ^/aplicaciones/xwiki$ /aplicaciones/xwiki/ [R]
        
        # Inserta aplicaciones/xwiki donde xwiki no lo hace. 
        # R=307 para que mantenga los metodos POST
        RewriteRule ^/bin/(.*)$ /aplicaciones/xwiki/bin/$1 [R=307,L]
        RewriteRule ^/rest/(.*)$ /aplicaciones/xwiki/rest/$1 [R=307,L]
        RewriteRule ^/asyncrenderer/(.*)$ /aplicaciones/xwiki/asyncrenderer/$1 [R=307,L]

        # Corrige la codificacion de la barra
        AllowEncodedSlashes NoDecode
        RewriteRule ^/aplicaciones%2Fxwiki/(.*)$ /aplicaciones/xwiki/$1 [R=301,L,NE]

            
        ProxyRequests Off
        ProxyPreserveHost On

        # Proxy Reverse
        ProxyPass /aplicaciones/xwiki/ http://xwiki:8080/ 
        ProxyPassReverse /aplicaciones/xwiki/ http://xwiki:8080/

    </VirtualHost>



#### Fichero configuración xwiki-config/xwiki.cfg

Asegurate que la primera vez que se inicie xwiki los campos de configuración del CAS que se encuentran al final del fichero estén comentado porque si no dará error por no estar instalado aún el plugin del CAS.

    vim xwiki-config/xwiki.cfg


    # # CAS authentication
    # xwiki.authentication.authclass=org.xwiki.contrib.authentication.cas.XWikiCASAuthenticator

    # # CAS server url (i.e. https://localhost:8443/cas)
    # xwiki.authentication.cas.server=https://cas:9443/cas


    # # possible values are CAS20 or SAML11
    # xwiki.authentication.cas.protocol=CAS20

    # # 0 or 1 if create XWiki user after log in
    # xwiki.authentication.cas.create_user=0

    # # 0 or 1 if update user attributes after every log in
    # xwiki.authentication.cas.update_user=0

Busca en el mismo fichero el siguiente campo. Debe tener el mismo contexto que en el proxy reverse del fichero de configuración httpd.conf de apache

    xwiki.webapppath=aplicaciones/xwiki/

Si se va a utilizar el xwiki con el nombre del frontal del gobcan, hay que modifcar en este fichero xwiki.cfg la propiedad:

    xwiki.home=https://gobcan.mv:10443/

#### Fichero de propiedades xwiki-config/xwiki.properties

Inserta en el siguiente campo el nombre del dominio del CAS para que xwiki no lo bloquee.

    vim xwiki-config/xwiki.properties

    url.trustedDomains=cas


### Docker-compose UP

Una vez modificado compila y lanza el docker-compose

    docker-compose build --no-cache
    docker-compose up -d
    docker-compose logs -f

Hay creado 3 ficheros con extensión sh que son atajos para levantar y parar el docker-compose, y para mostrar el logs

### Configuración inicial

Abre en el navegador la URL de xwiki

https://xwiki.mv/aplicaciones/xwiki/

La primera vez que entras en xwiki se mostrará el wizard de configuración inicial. Instala la extensión **XWiki Standard Flavor**


## Configuracion certificado en el CAS

Abre el cas en el navegador y comprueba que el certificado del CAS instalado coincide con la URL

https://cas:9443/cas/login

El certificado del CAS se guarda en el fichero **cas-config/thekeystore** y se instala con la herramienta keytool que debe coincidir con la versión de java del CAS que es 1.8, por lo que lo mejor es instalarlo dentro del contenedor.

Crea un fichero p12 con la clave pública y privada del cas

    openssl pkcs12 -export -in cas.crt -inkey cas.key -out cas.p12 -name cas

    Enter Export Password: changeit
    Verifying - Enter Export Password: changeit
    
Instalamos el certificado generado en el thekeystore

    # Copia el certificado cas.crt dentro del contenedor
    docker cp cas.p12 xwiki-cas:/etc/cas/

    # Abre la terminal del contenedor del cas
    docker exec -it xwiki-cas bash

    # Guarda el certificado dentro de thekeystore
    cd /etc/cas/
    keytool -importkeystore -destkeystore thekeystore -srckeystore cas.p12 -srcsto
    retype PKCS12 -alias cas -storepass changeit

    # Muestra los certificados instalados
    keytool -list -keystore thekeystore -storepass changeit

    # Borra los certificados que no son necesario
    keytool -delete -alias xwiki.mv -keystore thekeystore -storepass changeit

    exit

Reinicia el contenedor cas

    docker restart xwiki-cas


### Configuración CAS en Xwiki

Autentificate en xwiki con el usuario admin y abre el panel de administración, pulsando en el botón Drawer > Administer Wiki arriba a la derecha
Instala la extensión **Authenticator Jasig CAS**

Una vez instalado detiene xwiki

    docker stop xwiki

Modifica la parte final del fichero xwiki.cfg, descomentando las siguientes instrucciones y  modificando la dirección del cas por la correspondiente

    # CAS authentication
    xwiki.authentication.authclass=org.xwiki.contrib.authentication.cas.XWikiCASAuthenticator

    # CAS server url (i.e. https://localhost:8443/cas)
    xwiki.authentication.cas.server=http://cas:9443/cas

    # possible values are CAS20 or SAML11
    xwiki.authentication.cas.protocol=CAS20

    # 0 or 1 if create XWiki user after log in
    xwiki.authentication.cas.create_user=0

    # 0 or 1 if update user attributes after every log in
    xwiki.authentication.cas.update_user=0

Una vez modificado el fichero arranca xwiki

    docker start xwiki

Abre en el navegador la xwiki
https://xwiki.mv/aplicaciones/xwiki/

Al realizar login debe mostrar la ventana del CAS

Si después de autenticarse en el CAS se recibe la siguiente execpción:

    javax.net.ssl.SSLHandshakeException: PKIX path building failed

Es necesario añadir el certificado del CAS en el cacerts de xwiki.

    # Copia el certificado cas.p12 a xwiki
    docker cp cas.p12 xwiki:/opt/java/openjdk/lib/security/

    # Abre el terminal del contenedor
    docker exec -it xwiki bash

    # Copia el certificado
    cd /opt/java/openjdk/lib/security/
    keytool -importkeystore -destkeystore cacerts -srckeystore cas.p12 -srcstoretype PKCS12 -alias cas -deststorepass changeit -srcstorepass changeit

    exit

Reinicia el contenedor

    docker restart xwiki

