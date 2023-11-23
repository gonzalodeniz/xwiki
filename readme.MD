# XWIKI

## Instalación xwiki

Sitúate en la misma carpeta donde se encuentra el fichero docker-compose.yml y ejecuta el docker-compose:

```
docker-compose up -d
```

### Configuración inicial de xwiki

Paso 1: Introduce los datos del usuario admin:

```
First Name: admin
Last Name:
Username: admin
Password: 1q2w3e4R.

```

Paso 2: Instala XWiki Standard Flavor


Comprueba si se ejecuta correctamente (xwiki.mv es un nombre local de dns que apunta a la máquina donde está instalado xwiki)

 http://localhost:8080/bin/view/Main
 http://xwiki.mv:8080/bin/view/Main


## Referencias
- https://xwiki.com/en/Blog/HowtoinstallXWikiusingDocker/
- https://github.com/xwiki-contrib/docker-xwiki/blob/master/README.md
- https://github.com/xwiki-contrib/authenticator-jasig-cas





