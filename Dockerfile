#This is a sample Image
FROM ubuntu:18.04
MAINTAINER tushar.jadhav@adapty.com

# envs
ENV INSTALL_DIR /var/www/html/m2

#Intslling nginx , php7.2
RUN ln -sf /usr/share/zoneinfo/UTC /etc/localtime \
 && apt-get update \
 && apt-get install -y nginx  php7.2
	
#Setting timme zone and set cronjob and removing exsting nginx files 
RUN  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  /etc/nginx/sites-available/*  /etc/nginx/sites-enabled/*

	
# add magento cron job and auth file in root path
COPY ./crontab /etc/cron.d/magento2-cron  
COPY ./auth.json /root/.composer/auth.json 
COPY ./default /etc/nginx/sites-available/ 
COPY ./entrypoint.sh /entrypoint.sh



# set working dir
WORKDIR $INSTALL_DIR

ENTRYPOINT ["/entrypoint.sh"]

#Starting nginx and php7.2-fpm
CMD service php7.2-fpm start && service php7.2-fpm nginx

#Expose ports
EXPOSE 80
EXPOSE 443
