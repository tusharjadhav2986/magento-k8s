#This is a sample Image
FROM ubuntu:18.04
MAINTAINER tushar.jadhav@adapty.com

# envs
ENV INSTALL_DIR /var/www/html/m2

#Intslling nginx , php7.2
RUN ln -sf /usr/share/zoneinfo/UTC /etc/localtime \
 && apt-get update \
 && apt-get install -y nginx  php7.2
	
	
EXPOSE 80
EXPOSE 443
