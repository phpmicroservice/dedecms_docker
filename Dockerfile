FROM php:5.6-apache
MAINTAINER Dongasai <1514582970@qq.com>

WORKDIR /tmp;
RUN apt-get update;apt-get install -y vim wget zip zlib1g-dev
RUN apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev
# 安装扩展
RUN docker-php-ext-install pdo pdo_mysql mysql mysqli mbstring zip bcmath;docker-php-ext-enable pdo pdo_mysql mysql mysqli mbstring zip bcmath;
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
	&& docker-php-ext-install gd
# 下载dedecms
RUN wget http://updatenew.dedecms.com/base-v57/package/DedeCMS-V5.7-UTF8-SP2.tar.gz;tar -zxvf DedeCMS-V5.7-UTF8-SP2.tar.gz;cd DedeCMS-V5.7-UTF8-SP2;cp -rf uploads/. /var/www/html/;rm -fr *;cd /var/www/html/;chmod 777 *
WORKDIR /var/www/html/

EXPOSE 80