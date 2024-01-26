''' Crea usuarios en XWiki desde un CSV, utilizando las API.

    Autor: Gonzalo Déniz (Inerza, SA)
    Fecha: Enero 2024
'''

from xwiki_api_class import XWikiAPI

def importa_usuarios_csv(cnx:dict, file_csv:str) -> None:
    print('Comienza importación de usuarios')
    xwiki_api = XWikiAPI(cnx['cas_site'],
                         cnx['xwiki_site'],
                         cnx['username'], 
                         cnx['password'])
    
    xwiki_api.create_user_csv('api-rest//usuarios.csv')
    print('Finaliza la importación de usuarios')

def main():
    cnx = {'cas_site':   "https://xwiki-cas:8443",
           'xwiki_site': "https://xwiki.mv/aplicaciones/ciberwiki",
           'username':   "admin",
           'password':   "admin"}
    
    file_csv = 'api-rest//usuarios.csv'
    importa_usuarios_csv(cnx, file_csv)


if __name__ == "__main__":
    main()

