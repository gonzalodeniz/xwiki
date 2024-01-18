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

    def get_page(self, page_url:str) -> str:
        ''' Obtiene el código fuente de una pagina'''
        response = self.session.get(page_url, verify=False)
        return response.text
    
    def create_page(self, page_name:str, content:str='', data:str=None) -> requests.Response:        
        ''' Crea una página.
                page_name - Nombre de la pagina
                content   - Contenido de la pagina
                data      - Estructura xml del contenido de una pagina. 
                            Si no se especifica se utiliza unos datos básicos por defecto

            Informacion sobre la estructura de la pagina xml:
                https://xwiki.mv/aplicaciones/ciberwiki/rest/wikis/xwiki/spaces/Main/pages/<nombre_pagina>        
        '''
        url = f"{self.api_base}/wikis/xwiki/spaces/Main/pages/{page_name}" 

        headers = {'Content-Type': 'application/xml; charset=utf-8', 
                   'XWiki-Form-Token': self.xwiki_form_token}
        
        # Datos por defecto de una pagina
        data_default = f'''<page xmlns="http://www.xwiki.org">     
        <id>{page_name}</id>
        <title>{page_name}</title>
        <syntax>xwiki/2.0</syntax>
        <content>{content}</content>
    </page>'''
        if data is None:
            data = data_default

        data_encoded = data.encode('utf-8')         
        response = self.session.put(url, data=data_encoded, headers=headers, verify=False)
        return response



    def create_user(self, username:str, data:dict=None) -> requests.Response:    
        ''' Crea una usuario.
                username - Nombre del usuario

            Informacion sobre la estructura del objeto usuario en xml:
                https://xwiki.mv/aplicaciones/ciberwiki/rest/wikis/xwiki/spaces/Main/pages/admin/objects 
        '''
        
        # Crea una pagina con el nombre del usuario.
        self.create_page(username)

        # Crea el objeto usuario        
        url = f"{self.api_base}/wikis/xwiki/spaces/Main/pages/{username}/objects"
        headers = {"Content-Type": "application/x-www-form-urlencoded", 'XWiki-Form-Token': self.__get_xwiki_form_token()}        
     

     
        data = {'className': 'XWikiUsers'}
        response = self.session.post(url, data=data, headers=headers, verify=False)
        return response



def main():
    cas_site = "https://xwiki-cas:8443"
    xwiki_site = "https://xwiki.mv/aplicaciones/ciberwiki"
    username = "admin"
    password = "admin"

    xwiki_api = XWikiAPI(cas_site, xwiki_site, username, password)
    
    # Crea usuario
    response = xwiki_api.create_user("user003")
    print(response.status_code)


if __name__ == "__main__":
    main()
