FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y
RUN apt-get upgrade -y

RUN apt-get install -y apache2
RUN apt-get install -y mysql-client
RUN apt-get install -y php 
RUN apt-get install -y libapache2-mod-php 
RUN apt-get install -y php-mysql
RUN apt-get install -y git

RUN mkdir /var/www/mysite/
RUN git clone https://github.com/WordPress/WordPress.git /var/www/mysite/

COPY ./site.conf /etc/apache2/sites-available/

RUN chown -R www-data:www-data /var/www/mysite/
RUN chmod -R 755 /var/www/mysite/

RUN a2ensite site.conf
RUN a2dissite 000-default.conf
RUN a2enmod rewrite

RUN service apache2 restart

CMD ["apachectl","-D","FOREGROUND"]

EXPOSE 80
EXPOSE 443
EXPOSE 3306

