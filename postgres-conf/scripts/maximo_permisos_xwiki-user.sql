-- Ejecutar script como usuario postgres y conectado a la base de datos xwiki

-- Asigna los máximos privilegios al usuario xwiki-user
GRANT ALL PRIVILEGES ON SCHEMA public TO "xwiki-user";
GRANT ALL PRIVILEGES ON DATABASE xwiki TO "xwiki-user";
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO "xwiki-user";
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO "xwiki-user";
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public TO "xwiki-user";
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO "xwiki-user";


