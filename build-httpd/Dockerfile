FROM httpd:2.4

RUN apt update; apt install -y libapache2-mod-auth-cas; chmod a+wx /var/cache/apache2/mod_auth_cas/
RUN mkdir -p /etc/ssl/certs/

WORKDIR /usr/local/apache2

COPY httpd.conf conf/
COPY server.crt conf/
COPY server.key conf/

# COPY gobcan.mv.crt /etc/ssl/certs/gobcan.mv.crt
# Este enlace debe ser el hash de gobcan.crt
# RUN ln -s /etc/ssl/certs/gobcan.mv.crt /etc/ssl/certs/9a94bef5.0

#https
EXPOSE 443

#http
EXPOSE 80

CMD ["httpd-foreground"]


