
from xwiki_api_class import XWikiAPI



def main():
    cas_site = "https://xwiki-cas:8443"
    xwiki_site = "https://xwiki.mv/aplicaciones/ciberwiki"
    username = "admin"
    password = "admin"

    xwiki_api = XWikiAPI(cas_site, xwiki_site, username, password)
    xwiki_api.create_user_csv('api-rest//usuarios.csv')



    


if __name__ == "__main__":
    main()

