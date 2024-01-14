-- Ejecutar script como usuario postgres y conectado a la base de datos xwiki

-- Elimina los privilegios
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM "xwiki-user";
REVOKE ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public FROM "xwiki-user";
REVOKE ALL PRIVILEGES ON DATABASE xwiki FROM "xwiki-user";



-- Asigna los permisos solo de consultas y modificación de datos
GRANT SELECT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO "xwiki-user";




