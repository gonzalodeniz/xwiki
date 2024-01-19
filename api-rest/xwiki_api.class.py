import requests
from urllib.parse import urlencode, quote
import json
import re

# Suprime las advertencias de certificados SSL no verificados
requests.packages.urllib3.disable_warnings(requests.packages.urllib3.exceptions.InsecureRequestWarning)

class XWikiAPI:
    def __init__(self, cas_site:str, xwiki_site:str, username:str, password:str) -> None:
        self.cas_site = cas_site
        self.xwiki_site = xwiki_site
        self.api_base = xwiki_site + '/rest'
        self.session = self.__auth_cas(username, password)
        self.xwiki_form_token = self.__get_xwiki_form_token()

    def __auth_cas(self, username:str, password:str) -> requests.Session:
        ''' Autentifica contra el cas obteniendo un objeto de sesion'''
        # Codifica la URL
        xwiki_site_code = quote(self.xwiki_site)
        xwiki_site_code2 = quote(xwiki_site_code)
        service = f"{xwiki_site_code}%2Fbin%2Flogin%2FXWiki%2FXWikiLogin%3Fxredirect%3D%252F{xwiki_site_code2}%252Fbin%252Fview%252FMain%252F%26loginLink%3D1"        
        cas_url_login = f"{self.cas_site}/cas/login?service={service}"
        
        # Inicializa sesion
        session = requests.Session()
        response = session.get(cas_url_login, verify=False)
        cas_id_match = re.search(r'name="execution" value="([^"]*)"', response.text)

        # Obtiene el cas_id
        if not cas_id_match:
            raise ValueError("Login ticket is empty.")
        cas_id = cas_id_match.group(1)
        data = {
            "username": username,
            "password": password,
            "execution": cas_id,
            "_eventId": "submit"
        }

        # Autentifica
        response = session.post(cas_url_login, data=data, verify=False, allow_redirects=False)
        if 'Location' not in response.headers:
            raise ValueError("Cannot login. Check your credentials and URL.")
        dest_ticket = response.headers['Location']
        session.get(dest_ticket, verify=False)
        return session

    def __get_xwiki_form_token(self) -> str:
        ''' Obtiene el xwiki_form_token necesario para trabajar con las api de xwiki'''
        response = self.session.get(self.api_base, verify=False)
        return response.headers.get('XWiki-Form-Token')
        

    def get_page(self, page:str, wiki:str='xwiki', space:str='Main', json:bool=True) -> str:
        ''' Obtiene una pagina
                page - Ide de la pagina
                wiki - Seleccion de wiki en el caso que esté configurado las multiwiki
                space - Nombre del espacio donde se encuentra la pagina
                json - True devuelve los datos de la página en json, false en XML.
            API que utiliza https://xwiki.mv/aplicaciones/ciberwiki/rest/wikis/xwiki/spaces/Main/pages/pagina1
        '''
        url = f"{self.api_base}/wikis/{wiki}/spaces/{space}/pages/{page}" 
        if json:
            url += '?media=json'

        response = self.session.get(url, verify=False)
        self._handle_page_response(response)
        
        return response.text
    
    def create_page(self, page:str, content:str='', data:str=None, wiki:str='xwiki', space:str='Main') -> requests.Response:        
        ''' Crea una página.
                page_name - Nombre de la pagina
                content   - Contenido de la pagina
                data      - Estructura en json del contenido de una pagina. 
                            Si no se especifica se utiliza unos datos básicos por defecto
                wiki - Seleccion de wiki en el caso que esté configurado las multiwiki
                space - Nombre del espacio donde se encuentra la pagina
                            
            Informacion sobre la estructura de la pagina xml:
                https://xwiki.mv/aplicaciones/ciberwiki/rest/wikis/xwiki/spaces/Main/pages/<nombre_pagina>        
        '''
        url = f"{self.api_base}/wikis/{wiki}/spaces/{space}/pages/{page}" 

        headers = {'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8', 
                   'XWiki-Form-Token': self.xwiki_form_token}

        # Datos por defecto de una pagina
        data_default = {'id': {page},
                        'title': {page},
                        'syntax': 'xwiki/2.0',
                        'content': {content}}
        if data is None:
            data = data_default

        # data_encoded = data.encode('utf-8')         
        response = self.session.put(url, data=data, headers=headers, verify=False)
        self._handle_page_response(response)

        return response

    def _handle_page_response(self, response:requests.Response) -> None:
        ''' Gestiona los códigos de respuesta de una página'''
        if response.status_code == 200:
            print('the request was successful.')
        elif response.status_code == 201:
            print('the page was created.')
        elif response.status_code == 202:
            print('the page was update.')            
        elif response.status_code == 204:
            print('the page was delete.')               
        elif response.status_code == 304:
            print('the page was not modified.')        
        else:
            raise ValueError(f"Error al crear la página. \n{response.text}\nCodigo: {response.status_code}" )


    def create_user(self, username:str, data:dict=None, wiki:str='xwiki', space:str='Main') -> requests.Response:    
        ''' Crea una usuario.
                username - Nombre del usuario
                wiki - Seleccion de wiki en el caso que esté configurado las multiwiki
                space - Nombre del espacio donde se encuentra la pagina                

            Informacion sobre la estructura del objeto usuario en xml:
                https://xwiki.mv/aplicaciones/ciberwiki/rest/wikis/xwiki/spaces/Main/pages/admin/objects 
        '''
        
        # Crea una pagina con el nombre del usuario.
        self.create_page(username, wiki=wiki, space=space)
        
        # Crea el objeto usuario        
        url = f"{self.api_base}/wikis/{wiki}/spaces/{space}/pages/{username}/objects"         
        headers = {"Content-Type": "application/x-www-form-urlencoded", 'XWiki-Form-Token': self.__get_xwiki_form_token()}        
     
        data = {'className': 'XWikiUsers',
                'property#first_name': {username}}
        
        response = self.session.post(url, data=data, headers=headers, verify=False)
        self._handle_object_response(response)
        return response

    def _handle_object_response(self, response:requests.Response) -> None:
        ''' Gestiona los códigos de respuesta de un objecto'''
        if response.status_code == 200:
            print('the request was successful.')
        elif response.status_code == 201:
            print('the object was created.')
        elif response.status_code == 202:
            print('the object was update.')            
        elif response.status_code == 204:
            print('the object was delete.')                     
        else:
            raise ValueError(f"Error al crear la página. \n{response.text}\nCodigo: {response.status_code}" )

def main():
    cas_site = "https://xwiki-cas:8443"
    xwiki_site = "https://xwiki.mv/aplicaciones/ciberwiki"
    username = "admin"
    password = "admin"

    xwiki_api = XWikiAPI(cas_site, xwiki_site, username, password)



    ## Crea una página
    #xwiki_api.create_page('página3', content='Esto es la página 3')
    
    ## Muestra  el contenido de una pagina
    # page = xwiki_api.get_page('página3')
    # page_json = json.loads(page)
    # print(f"Pagina {page_json['title']}\nContenido: {page_json['content']}")        
    
    ## Crea usuario
    response = xwiki_api.create_user("user004")
    


if __name__ == "__main__":
    main()
