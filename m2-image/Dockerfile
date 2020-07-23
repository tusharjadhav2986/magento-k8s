#This is a sample Image
FROM ubuntu:18.04
MAINTAINER tushar.jadhav@adapty.com

# envs
ENV INSTALL_DIR /var/www/html/m2

#Intslling nginx , php7.2
RUN ln -sf /usr/share/zoneinfo/UTC /etc/localtime \
 && apt-get update \
 && apt-get install -y nginx  php7.2 \
    php7.2-apc \
    php7.2-bcmath \
    php7.2-common \
    php7.2-curl \
    php7.2-cgi  \
    php7.2-cli \
    php7.2-dev \
    php7.2-fileinfo \
    php7.2-fpm \
    php7.2-gd \
    php7.2-intl \
    php7.2*intl \
    php7.2-json \
    php7.2-ldap \
    php7.2-mysql \
    php7.2-mbstring \
    php7.2-soap \
    php7.2-xsl  \
    php7.2-xml \
    php7.2-zip \
	curl \
	wget \
	git \
	unzip \
	cron \
	vim 
	
#Setting timme zone and set cronjob and removing exsting nginx files 
RUN  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  /etc/nginx/sites-available/*  /etc/nginx/sites-enabled/*

	
# add magento cron job and auth file in root path
COPY ./crontab /etc/cron.d/magento2-cron  
COPY ./auth.json /root/.composer/auth.json 
COPY ./default /etc/nginx/sites-available/ 
COPY ./entrypoint.sh /entrypoint.sh


#Installing Composer and set nginx default file and set php memory limits and clear packages
RUN ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/ \
&& curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer \
&& composer -V \
&& sed -i "s|128M|2048M|g" /etc/php/7.2/fpm/php.ini \
&& sed -i "s|cgi.fix_pathinfo=1|cgi.fix_pathinfo=0|g" /etc/php/7.2/fpm/php.ini \
&& sed -i '/cgi.fix_pathinfo/s/^;//g' /etc/php/7.2/fpm/php.ini \
&& chmod 0644 /etc/cron.d/magento2-cron \
&& crontab -u root /etc/cron.d/magento2-cron \
&& chown -R www-data:www-data /var/www


# set working dir
WORKDIR $INSTALL_DIR

ENTRYPOINT ["/entrypoint.sh"]

#Starting nginx and php7.2-fpm
CMD service php7.2-fpm start && service php7.2-fpm nginx

#Expose ports
EXPOSE 80
EXPOSE 443
