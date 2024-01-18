import requests
from urllib.parse import urlencode
from requests.packages.urllib3.exceptions import InsecureRequestWarning
import tempfile
import re


print("\n\n## Comienza el test de conexion con las API REST de xwiki")

# Define the CAS server URL and credentials
CAS_HOSTNAME = "https://xwiki-cas:8443"
CAS_FULL_URL = CAS_HOSTNAME + "/cas/login?service=https%3A%2F%2Fxwiki.mv%2Faplicaciones%2Fciberwiki%2Fbin%2Flogin%2FXWiki%2FXWikiLogin%3Fxredirect%3D%252Faplicaciones%252Fciberwiki%252Fbin%252Fview%252FMain%252F%26loginLink%3D1"
USERNAME = "admin"
PASSWORD = "admin"
SITE = "https://xwiki.mv/aplicaciones/ciberwiki"
PAGE_PRIVADA = "/rest/wikis/xwiki/spaces/privado/pages/WebHome"
PAGE_PUBLICA = "/rest/wikis/xwiki/spaces/publico/pages/WebHome"
DEST = SITE + PAGE_PRIVADA
ENDPOINT = SITE + '/rest/wikis/xwiki/spaces/XWiki/pages/{username}/objects'


# Suprimir las advertencias de certificados SSL no verificados
requests.packages.urllib3.disable_warnings(InsecureRequestWarning)


# Initialize session
print("## Captura la cookie de sesion de xwiki")
session = requests.Session()
response = session.head(SITE, verify=False)
print("\nCOOKIE=\n", session.cookies)

# Captura el CAS_ID
print("\n## Captura lel CAS_ID\n")
response = session.get(CAS_FULL_URL, verify=False)
# Extract CAS_ID using regex
cas_id_match = re.search(r'name="execution" value="([^"]*)"', response.text)
if cas_id_match:
    CAS_ID = cas_id_match.group(1)
    print(CAS_ID)
else:
    print("Login ticket is empty.")
    exit(1)

print("## Envia las credenciales del usuario al CAS")
# Submit the CAS login form
data = {
    "username": USERNAME,
    "password": PASSWORD,
    "execution": CAS_ID,
    "_eventId": "submit"
}
response = session.post(CAS_FULL_URL, data=data, verify=False, allow_redirects=False)
# Print session cookies
print("\nCOOKIE=\n", session.cookies)

# Check if login was successful
if 'Location' not in response.headers:
    print("Cannot login. Check your credentials and URL.")
    exit(1)

# Follow the redirection URL to get authenticated
print("\n## Obtiene el código del ticket\n")    
dest_ticket = response.headers['Location']
response = session.get(dest_ticket, verify=False)
print(dest_ticket)

# # Access the desired destination
# print("\n## Visualiza la página privada\n")    
# response = session.get(DEST, verify=False)
# # Print the content of the destination page
# print(response.text)

# Creacion de usuario
# Replace '{username}' with the desired username
username = 'ext-gdenaco'

# Update the URL with the username
url_create_user = ENDPOINT.format(username=username)

# Prueba para ver que muestra
# response = session.get(url_create_user, verify=False)
# # Print the content of the destination page
# print(response.text)
# exit


# Data for the new user
data = {
    'className': 'XWiki.XWikiUsers',
    'property#first_name': 'Gonzalo',     # Replace with the user's first name
    'property#last_name': 'Deniz',       # Replace with the user's last name
    'property#email': 'gdeniz@inerza.com',  # Replace with the user's email
    # Add other necessary properties here
}

# Send the POST request
print(url_create_user)
response = session.post(url_create_user, data=data, verify=False)

# Check the response
if response.status_code == 201:
    print('User created successfully.')
else:
    print('Failed to create user:', response.status_code, response.text)
