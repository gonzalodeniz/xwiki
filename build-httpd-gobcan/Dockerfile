FROM httpd:2.4

RUN apt update; apt install -y libapache2-mod-auth-cas curl; chmod a+wx /var/cache/apache2/mod_auth_cas/
RUN mkdir -p /etc/ssl/certs/

WORKDIR /usr/local/apache2

COPY httpd.conf conf/
COPY gobcan.crt conf/
COPY gobcan.key conf/
# COPY cas.crt /etc/ssl/certs/cas.crt

# Este enlace debe ser el hash de gobcan.crt
# RUN ln -s /etc/ssl/certs/cas.crt /etc/ssl/certs/cbe45755.0

#https
EXPOSE 10443


CMD ["httpd-foreground"]


