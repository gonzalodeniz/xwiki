## Carpetas y configuración de Base de datos
mkdir mysql-init
mkdir mysql
mkdir data_xwiki
echo "grant all privileges on *.* to xwiki@'%' identified by 'xwiki'" > mysql-init/init.sql

## Java Apereo CAS Client
git clone https://github.com/apereo/java-cas-client.git
cd java-cas-client
mvn clean package

## Vuelve al espacio de disco de ejecución del script
cd ../