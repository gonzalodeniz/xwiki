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

    openssl req -x509 -newkey rsa:2048 -keyout server.key -out server.crt -days 365 -nodes -subj "/CN=xwiki.mv" -addext "subjectAltName=DNS:xwiki.mv,DNS:xwiki,DNS:192.168.56.101,DNS:localhost"

Para comprobar el fichero crt creado:
    
    openssl x509 -in server.crt -text -noout

Sustituye el fichero cas.crt generado por el que se encuentra en la carpeta cas-config.
Certificado del CAS. El nombre de xwiki-cas deberá ser sustituido por el nombre del servidor real del CAS. 
Si se está montando todo en el mismo servidor con contenedores, debe asegurarte que añadir en el fichero /etc/hosts la entrada xwiki-cas con la ip correspondiente.


    cd cas-config

    openssl req -x509 -newkey rsa:2048 -keyout cas.key -out cas.crt -days 365 -nodes -subj "/CN=xwiki-cas" -addext "subjectAltName=DNS:xwiki-cas,DNS:cas,DNS:192.168.56.101,DNS:localhost"

Crea el fichero p12

    openssl pkcs12 -export -in cas.crt -inkey cas.key -out cas.p12 -name xwiki-cas
    Enter Export Password: changeit
    Verifying - Enter Export Password: changeit


### Parámetros de configuración

Se describe brevemente los parámetros para configuraciones personalizadas menos conocidas

#### Docker-compose.yml

Servicio xwiki:
- parámetro **CONTEXT_PATH: aplicaciones#xwiki**: Modifica el contexto de la aplicación 

#### build-httpd/Dockerfile

Nombre de los certificados

#### build-httpd/httpd.conf

Aquí se configuran las rutas del contexto y el proxy-reverse para modificar el contexto.

#### xwiki-config/xwiki.cfg

Si la ruta de acceso es diferente al nombre del servidor, por ejemplo gobcan.mv, hay que descomentar y editar la propiedad xwiki.home con el nombre y puerto de acceso. Si no, se comenta.
Si el nombre de entrada a la aplicación es directamente el nombre del servidor sería

Sustituye xwiki.mv por el nombre de tu servidor

    xwiki.home=https://xwiki.mv/

Busca en el mismo fichero el campo webappath que nos indica el contexto. Debe tener el mismo contexto que en el proxy reverse del fichero de configuración httpd.conf de apache y la variable de entorno ONTEXT_PATH del docker-compose

    xwiki.webapppath=aplicaciones/xwiki/


Asegurate que la primera vez que se inicie xwiki los campos de configuración del CAS que se encuentran al final del fichero estén comentado porque si no dará error por no estar instalado aún el plugin del CAS.

vim xwiki-config/xwiki.cfg


    # # CAS authentication
    # xwiki.authentication.authclass=org.xwiki.contrib.authentication.cas.XWikiCASAuthenticator

    # # CAS server url (i.e. https://localhost:8443/cas)
    # xwiki.authentication.cas.server=https://xwiki-cas:8443/cas


    # # possible values are CAS20 or SAML11
    # xwiki.authentication.cas.protocol=CAS20

    # # 0 or 1 if create XWiki user after log in
    # xwiki.authentication.cas.create_user=0

    # # 0 or 1 if update user attributes after every log in
    # xwiki.authentication.cas.update_user=0


#### xwiki-config/xwiki.properties
Inserta en el siguiente campo el nombre del dominio del CAS para que xwiki no lo bloquee. Puedes añadir más dominio separados por coma.

    url.trustedDomains=xwiki-cas


### Actualiza el keystore del CAS
El certificado del CAS se guarda en el fichero cas-config/thekeystore y se instala con la herramienta keytool que debe coincidir con la versión de java del CAS que es 1.8, por lo que lo instalamos dentro del contenedor.
Arranca únicamente el CAS

    docker-compose up -d xwiki-cas

Instala el certificado generado en el thekeystore

    cd cas-config/

    # Copia el certificado cas.crt dentro del contenedor
    docker cp cas.p12 xwiki-cas:/etc/cas/

    # Abre la terminal del contenedor del cas
    docker exec -it xwiki-cas bash

    # Cambia a la carpeta donde se encuentra el keystore
    cd /etc/cas/

    # Muestra los certificados almacenados en el keystore
    keytool -list -keystore thekeystore -storepass changeit

    # Borra los certificados que no son necesarios
    keytool -delete -alias cas -keystore thekeystore -storepass changeit

    # Guarda el certificado dentro de thekeystore
    keytool -importkeystore -destkeystore thekeystore -srckeystore cas.p12 -srcstoretype PKCS12 -alias xwiki-cas -storepass changeit    

Comprueba el certificado que se ha instalado

    keytool -list -keystore thekeystore -storepass changeit

    Keystore type: JKS
    Keystore provider: SUN

    Your keystore contains 1 entry

    xwiki-cas, Jan 6, 2024, PrivateKeyEntry, 
    Certificate fingerprint (SHA1): 6D:36:DC:0E:D0:5A:91:19:67:22:A7:9F:8E:DF:6C:2D:DA:96:4B:6C

Una vez actualizado paramos el contenedor

    exit
    docker-compose down
    cd ..


### Actualiza el keystore del XWIKI
Arranca únicamente el CAS

    docker-compose up -d xwiki

Instala el certificado generado en el cacerts

    # Copia el certificado cas.p12 a xwiki
    docker cp cas.p12 xwiki:/opt/java/openjdk/lib/security/

    # Abre el terminal del contenedor
    docker exec -it xwiki bash

    # Mueve a la carpeta donde está el cacert
    cd /opt/java/openjdk/lib/security/

    # Muestra los certificados almacenados en el keystore
    keytool -list -cacerts -storepass changeit

    # Borra los certificados que no son necesarios
    keytool -delete -alias xwiki-cas -cacerts -storepass changeit

    # Guarda el certificado dentro de thekeystore
    keytool -importkeystore -destkeystore cacerts -srckeystore cas.p12 -srcstoretype PKCS12 -alias xwiki-cas -deststorepass changeit -srcstorepass changeit

    # Comprueba el certificado almacenados en el keystore
    keytool -list -cacerts -storepass changeit
    exit

Una vez actualizado paramos el contenedor

    exit
    docker-compose down
    cd ..


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



## Configuración CAS en Xwiki

Autentificate en xwiki con el usuario admin y abre el panel de administración, pulsando en el botón Drawer > Administer Wiki arriba a la derecha. Busca la extensión Authenticator Jasig CAS y pulsa el botón de instalar 

Una vez instalado detiene xwiki

    docker stop xwiki

Modifica la parte final del fichero xwiki.cfg, descomentando las siguientes instrucciones y  modificando la dirección del cas por la correspondiente

    # CAS authentication
    xwiki.authentication.authclass=org.xwiki.contrib.authentication.cas.XWikiCASAuthenticator

    # CAS server url (i.e. https://localhost:8443/cas)
    xwiki.authentication.cas.server=http://xwiki-cas:8443/cas

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
