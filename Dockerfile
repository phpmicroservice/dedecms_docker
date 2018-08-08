FROM yiwang666/lamp
MAINTAINER Medici.Yan <Medici.Yan@Gmail.com>

COPY src/dedecms.zip /tmp/dedecms.zip
COPY src/install.zip /tmp/install.zip
COPY src/dedecms.sql /tmp/dedecms.sql

RUN apt-get install -y unzip
#http://updatenew.dedecms.com/base-v57/package/DedeCMS-V5.7-UTF8-SP2.tar.gz
WORKDIR /tmp
RUN set -x \
    && apt-get install -y php5-mysql php5-dev php5-gd php5-memcache php5-pspell php5-snmp snmp php5-xmlrpc libapache2-mod-php5 php5-cli unzip \
    && rm -rf /var/www/html/* \
    && unzip -x /tmp/dedecms.zip \
    && unzip -x /tmp/install.zip \
    && cp -r /tmp/* /var/www/html/ \
    && cp -r /tmp/* /var/www/html/ \
    && /etc/init.d/mysql start \
    && mysql -e "CREATE DATABASE dedecms DEFAULT CHARACTER SET utf8;" -uroot -p \
    && mysql -e "use dedecms;source /tmp/dedecms.sql;" -uroot -p \
    && rm -rf /tmp/* \
    && chown -R www-data:www-data /var/www/html

COPY src/start.sh /start.sh
RUN chmod a+x /start.sh

EXPOSE 80
CMD ["/start.sh"]
