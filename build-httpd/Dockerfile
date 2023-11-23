FROM httpd:2.4

RUN apt update; apt install -y libapache2-mod-auth-cas; chmod a+wx /var/cache/apache2/mod_auth_cas/
RUN mkdir -p /etc/ssl/certs/

WORKDIR /usr/local/apache2

COPY httpd.conf conf/
COPY server.crt conf/
COPY server.key conf/
COPY cas.crt /etc/ssl/certs/cas.crt

RUN ln -s /etc/ssl/certs/cas.crt /etc/ssl/certs/f7349776.0

#https
EXPOSE 443

#http
EXPOSE 80

CMD ["httpd-foreground"]


