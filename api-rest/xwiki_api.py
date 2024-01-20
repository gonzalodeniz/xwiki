
from xwiki_api_class import XWikiAPI



def main():
    cas_site = "https://xwiki-cas:8443"
    xwiki_site = "https://xwiki.mv/aplicaciones/ciberwiki"
    username = "admin"
    password = "admin"

    xwiki_api = XWikiAPI(cas_site, xwiki_site, username, password)


    ## Crea una página
    #xwiki_api.create_page('página3', content='Esto es la página 3')
    
    ## Muestra  el contenido de una pagina
    # page_raw = xwiki_api.get_page('página3')
    # if page_raw.status_code == 200:
    #     page = json.loads(page_raw.text)
    #     print(f"Pagina {page['title']}\nContenido: {page['content']}")        
    
    ## Crea usuario
    data_user = {'property#first_name': 'Pepe Luis',
            'property#last_name': 'Rodriguez',
            'property#email': 'user001@mail.com'                  
            }
    response = xwiki_api.create_user("user001", data_user=data_user)    
    print(response.status_code)
    


if __name__ == "__main__":
    main()

