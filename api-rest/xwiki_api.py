
import requests
from urllib.parse import urlencode
import json
import re

print("\n\n## Comienza el test de conexion con las API REST de xwiki")

# Define the CAS server URL and credentials
CAS_SITE = "https://xwiki-cas:8443"
CAS_URL_LOGIN = CAS_SITE + "/cas/login?service=https%3A%2F%2Fxwiki.mv%2Faplicaciones%2Fciberwiki%2Fbin%2Flogin%2FXWiki%2FXWikiLogin%3Fxredirect%3D%252Faplicaciones%252Fciberwiki%252Fbin%252Fview%252FMain%252F%26loginLink%3D1"
XWIKI_SITE = "https://xwiki.mv/aplicaciones/ciberwiki"

API_BASE = XWIKI_SITE + '/rest'
API_PAGINA_PRIVADA = API_BASE + "/wikis/xwiki/spaces/privado/pages/WebHome"
API_PAGINA_PUBLICA = API_BASE + "/wikis/xwiki/spaces/publico/pages/WebHome"
API_CREAR_USUARIO = API_BASE + '/wikis/xwiki/spaces/XWiki/pages/{username}/objects'

# Suprimir las advertencias de certificados SSL no verificados
requests.packages.urllib3.disable_warnings(requests.packages.urllib3.exceptions.InsecureRequestWarning)


def auth_cas(username:str, password:str, debug:bool=False) -> requests.Session:
    # Initialize session
    session = requests.Session()
    response = session.head(XWIKI_SITE, verify=False)

    # Captura el cas_id    
    response = session.get(CAS_URL_LOGIN, verify=False)
    # Extract cas_id using regex
    cas_id_match = re.search(r'name="execution" value="([^"]*)"', response.text)
    if cas_id_match:
        cas_id = cas_id_match.group(1)        
    else:
        print("Login ticket is empty.")
        exit(1)
    if debug:
        print("\n** cas_id **\n")        
        print(cas_id)

    # Submit the CAS login form
    data = {
        "username": username,
        "password": password,
        "execution": cas_id,
        "_eventId": "submit"
    }        
    response = session.post(CAS_URL_LOGIN, data=data, verify=False, allow_redirects=False)

    # Check if login was successful
    if 'Location' not in response.headers:
        print("Cannot login. Check your credentials and URL.")
        exit(1)

    # Follow the redirection URL to get authenticated    
    dest_ticket = response.headers['Location']
    response = session.get(dest_ticket, verify=False)
    if debug:
        print(f'\n** Ticket **\n{dest_ticket}')    

    return session

def get_xwiki_form_token(session:requests.session) -> str:
    ''' Devuelve el valor "XWiki-Form-Token" de la cabecera
        de una respuesta a XWiki
    '''
    response = session.get(API_BASE, verify=False)
    xwiki_form_token = response.headers.get('XWiki-Form-Token')
    return xwiki_form_token

def get_page(session:requests.session, page:str) -> str:
    response = session.get(page, verify=False)
    return response.text

def crea_usuario(session:requests.session, xwiki_form_token:str, datos_usuario, username) ->requests.Response:
    
    url_create_user = API_CREAR_USUARIO.format(username=username)
    headers = {'XWiki-Form-Token':xwiki_form_token}
    response = session.post(url_create_user, data=datos_usuario, headers=headers, verify=False)
    
    # Check the response
    if response.status_code == 201:
        print('User created successfully.')
    else:
        print('Failed to create user:', response.status_code, response.text)

    return response

# Crear una página
def crea_pagina(session:requests.session, xwiki_form_token:str, nombre_pagina:str, contenido:str) -> requests.Response:    
    base_url = API_BASE + f'/wikis/xwiki/spaces/Main/pages/{nombre_pagina}'
    headers = {'Content-Type': 'application/xml', 
               'XWiki-Form-Token':xwiki_form_token}
    
    data = f'''<page xmlns="http://www.xwiki.org">     
    <title>{nombre_pagina}</title>
    <syntax>xwiki/2.0</syntax>
    <content>{contenido}</content>
</page>'''
    print(base_url)    
    respuesta = session.put(base_url, data=data, headers=headers, verify=False)
    return respuesta

def main() -> None:    
    api_pagina_privada = API_PAGINA_PRIVADA
    session = auth_cas("admin", "admin")
    xwiki_form_token = get_xwiki_form_token(session)
 

    # Muestra una página privada
    # contenido_pagina_privada = get_page(session, api_pagina_privada)
    # print(contenido_pagina_privada)

    # Crea usuario
    # Data for the new user
    # username = 'ext-gdenaco'
    # datos_usuario = {
    #     'className': 'XWiki.XWikiUsers',
    #     'property#first_name': 'Gonzalo',     # Replace with the user's first name
    #     'property#last_name': 'Deniz',       # Replace with the user's last name
    #     'property#email': 'gdeniz@inerza.com',  # Replace with the user's email
    #     # Add other necessary properties here
    # }    
    # response = crea_usuario(session, xwiki_form_token, datos_usuario, username)
  
    # Ejemplo de uso
    nombre_pagina = "Pagina 3"
    contenido = "Este es el contenido de mi nueva página en XWiki."

    # Crear una nueva página
    response = crea_pagina(session, xwiki_form_token, nombre_pagina, contenido)
    print(response.text)

main()
