import requests
from urllib.parse import urlencode, quote
import csv
import re
import logging

# Configuración básica del logging
logging.basicConfig(level=logging.INFO, format='%(message)s')

# Suprime las advertencias de certificados SSL no verificados
requests.packages.urllib3.disable_warnings(requests.packages.urllib3.exceptions.InsecureRequestWarning)  # type: ignore

class XWikiAPI:
    def __init__(self, cas_site:str, xwiki_site:str, username:str, password:str) -> None:
        logging.debug('Inicializando XWikiAPI')
        self.cas_site = cas_site
        self.xwiki_site = xwiki_site
        self.api_base = xwiki_site + '/rest'
        self.session = self.__auth_cas(username, password)
        self.xwiki_form_token = self.__get_xwiki_form_token()

    def __auth_cas(self, username:str, password:str) -> requests.Session:
        ''' Autentifica contra el cas obteniendo un objeto de sesion'''
        logging.debug('Autenticando con el CAS')
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

    def __get_xwiki_form_token(self) -> str|None:
        ''' Obtiene el xwiki_form_token necesario para trabajar con las api de xwiki'''
        logging.debug('Obteniendo el xwiki_form_token')
        response = self.session.get(self.api_base, verify=False)
        return response.headers.get('XWiki-Form-Token')
        
    def _handle_page_response(self, response:requests.Response) -> None:
        ''' Gestiona los códigos de respuesta de una página'''
        logging.debug(f"Status code = {response.status_code}")
        if response.status_code == 200:
            logging.debug('The request was successful.')
        elif response.status_code == 201:
            logging.debug('The page was created.')
        elif response.status_code == 202:
            logging.debug('The page was update.')            
        elif response.status_code == 204:
            logging.debug('The page was delete.')               
        elif response.status_code == 304:
            logging.debug('The page was not modified.')        
        else:
            raise ValueError(f"Error: \n{response.text}\nCodigo: {response.status_code}" )

    def _handle_object_response(self, response:requests.Response) -> None:
        ''' Gestiona los códigos de respuesta de un objecto'''
        logging.debug(f"Status code = {response.status_code}")
        if response.status_code == 200:
            logging.debug('The request was successful.')
        elif response.status_code == 201:
            logging.debug('The object was created.')
        elif response.status_code == 202:
            logging.debug('The object was update.')            
        elif response.status_code == 204:
            logging.debug('The object was delete.')                     
        else:
            raise ValueError(f"Error: \n{response.text}\nCodigo: {response.status_code}" )
          
    def get_page(self, page:str, wiki:str='xwiki', space:str='Main') -> requests.Response:
        ''' Obtiene un request.Rsponse de una pagina
                page - Id de la pagina
                wiki - Seleccion de wiki en el caso que esté configurado las multiwiki
                space - Nombre del espacio donde se encuentra la pagina                
            API que utiliza https://xwiki.mv/aplicaciones/ciberwiki/rest/wikis/xwiki/spaces/Main/pages/pagina1
        '''        
        logging.debug(f'Leyendo página: {page}')
        url = f"{self.api_base}/wikis/{wiki}/spaces/{space}/pages/{page}?media=json"                         
        response = self.session.get(url, verify=False)      
        self._handle_page_response(response)        
        return response
    
    def get_objects(self, page:str, class_name:str='', wiki:str='xwiki', space:str='Main') -> requests.Response:
        ''' Obtiene una lista de objetos de una pagina
                page - Id de la pagina
                class_name - Muestra los objetos de una clase
                wiki - Seleccion de wiki en el caso que esté configurado las multiwiki
                space - Nombre del espacio donde se encuentra la pagina                
            API que utiliza https://xwiki.mv/aplicaciones/ciberwiki/rest/wikis/xwiki/spaces/Main/pages/pagina1
        '''         
        logging.debug(f'Leyendo objeto: {page} - {class_name}')
        url = f"{self.api_base}/wikis/{wiki}/spaces/{space}/pages/{page}/objects{class_name}?media=json"                 
        response = self.session.get(url, verify=False)
        self._handle_page_response(response)
        return response      
    
    def create_page(self, page:str, content:str='', data:dict={}, wiki:str='xwiki', space:str='Main') -> requests.Response:        
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
        logging.debug(f'Creando página: {page}')
        url = f"{self.api_base}/wikis/{wiki}/spaces/{space}/pages/{page}" 
        headers = {'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8', 
                   'XWiki-Form-Token': self.xwiki_form_token}

        # Datos por defecto de una pagina
        data_default = {'id': {page},
                        'title': {page},
                        'syntax': 'xwiki/2.0',
                        'content': {content}}
        data = data_default|data
        response = self.session.put(url, data=data, headers=headers, verify=False)     
        self._handle_page_response(response)

        return response

    def create_object(self, page:str, data:dict, wiki:str='xwiki', space:str='XWiki') -> requests.Response:        
        ''' Crea una página.
                pages    - Nombre de la pagina
                data      - Estructura en json del objeto. 
                wiki - Seleccion de wiki en el caso que esté configurado las multiwiki
                space - Nombre del espacio donde se encuentra la pagina
                            
            Informacion sobre la estructura de la pagina xml:
                https://xwiki.mv/aplicaciones/ciberwiki/rest/wikis/xwiki/spaces/XWiki/pages/<nombre_pagina>/objects        
        '''  
        logging.debug(f"Creando objeto: {page} - {data}")      
        url = f"{self.api_base}/wikis/{wiki}/spaces/{space}/pages/{page}/objects" 
        headers = {'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8', 
                   'XWiki-Form-Token': self.xwiki_form_token}        
        response = self.session.post(url, data=data, headers=headers, verify=False)
        self._handle_page_response(response)
        return response

    def create_user(self, username:str, group:str='XWikiAllGroup', data_user:dict={}, data_rights:dict={}, wiki:str='xwiki', space:str='XWiki') -> requests.Response:    
        ''' Crea un usuario.
                username - Nombre del usuario
                group - Nombre del grupo al que pertenece el usuario
                data_user - Diccionario con los datos del usuario
                data_rights - Diccionario con los datos de permisos
                wiki - Seleccion de wiki en el caso que esté configurado las multiwiki
                space - Nombre del espacio donde se encuentra la pagina                

            Informacion sobre la estructura del objeto usuario en xml:
                https://xwiki.mv/aplicaciones/ciberwiki/rest/wikis/xwiki/spaces/Main/pages/admin/objects 
                https://xwiki.mv/aplicaciones/ciberwiki/rest/wikis/xwiki/spaces/XWiki/pages/admin/?objects=true
            
            Ejemplo de data de usuario
                data_user = {'
                    'property#first_name': 'Pepe Luis',
                    'property#last_name': 'Rodriguez',
                    'property#email': 'user001@mail.com'          
                    } 
                data_rights = {'
                    'property#groups': 'XWiki.XWikiAllGroup'         
                    }  
        '''
        logging.debug(f'Creando usuario: {username}')
        data_user_default = {'className': 'XWikiUsers',
                             'property#active': '1'         
        }
        data_rights_default = {'className': 'XWikiRights',
                                'property#allow': '1',
                                'property#groups': 'XWiki.' + group,
                                'property#users': 'XWiki.' + username   
        }
        data_group = {  'className': 'XWikiGroups',
                        'property#member': 'XWiki.' + username}

        # Combina los datos por defectos con los datos pasado por parámetros
        data_user = data_user_default|data_user 
        data_rights = data_rights_default|data_rights

        # Crea la pagina
        response = self.create_page(username, wiki=wiki, space=space)

        # Crea el usuario
        response = self.create_object(username, data=data_user)

        # Crea los derechos
        response = self.create_object(username, data=data_rights)

        # Asigna el grupo
        response = self.create_object(page=group, data=data_group)
        
        return response
   
    def create_user_csv(self,file_csv) -> None:
        ''' Crea los usuario a partir de un fichero csv'''
        logging.debug('Creando usuarios desde fichero CSV')
        try:
            lista_usuarios = []

            # Abre y lee el archivo CSV
            with open(file_csv, mode='r', encoding='utf-8') as csvfile:
                csv_reader = csv.DictReader(csvfile, delimiter=';')

                # Para cada fila en el CSV, añade un diccionario a la lista 'data'
                for row in csv_reader:
                    lista_usuarios.append(row)

            for usuario in lista_usuarios:
                data_user = {
                'property#first_name': usuario['first_name'],
                'property#last_name': usuario['last_name'],
                'property#email': usuario['email']        
                } 
                response = self.create_user(usuario['username'], usuario['group'], data_user)
                if response.status_code == 201:
                    logging.info(f'Usuario creado: {usuario}')
        except FileNotFoundError as e:
            print(e)
    
 