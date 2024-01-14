-- Ejecutar script como usuario postgres 

-- Crea la base de datos
CREATE DATABASE xwiki ENCODING 'UTF8';

-- Crea los usuarios
CREATE USER "xwiki-owner-user" WITH PASSWORD 'xwiki';
CREATE USER "xwiki-user" WITH PASSWORD 'xwiki';

-- Convierte al usuario xwiki-owner-user en propietario de la base de datos xwiki
ALTER DATABASE xwiki OWNER TO "xwiki-owner-user";




