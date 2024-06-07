-- Crea la base de datos 
CREATE DATABASE xwiki ENCODING 'UTF8'; 
-- Crea los usuarios, omitir si ya existen 
CREATE USER "cuestion-own-bd" WITH PASSWORD '??????'; 
CREATE USER "cuestion-bd" WITH PASSWORD '??????'; 
-- Convierte al usuario cuestion-own-bd en propietario de la base de datos xwiki 
ALTER DATABASE xwiki OWNER TO "cuestion-own-bd";