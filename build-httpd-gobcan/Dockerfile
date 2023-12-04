FROM httpd:2.4

RUN apt update; 


WORKDIR /usr/local/apache2

COPY httpd.conf conf/
COPY server.crt conf/
COPY server.key conf/


#https
EXPOSE 443

#http
EXPOSE 80

CMD ["httpd-foreground"]


