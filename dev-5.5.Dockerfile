FROM chialab/php-dev:5.5
MAINTAINER leonnleite@gmail.com

# install oci
COPY ./var/instantclient-basic-linux.x64-12.2.0.1.0.zip \
     ./var/instantclient-sdk-linux.x64-12.2.0.1.0.zip \
     ./var/instantclient-sqlplus-linux.x64-12.2.0.1.0.zip /tmp/

RUN apt-get update && apt-get install -y unzip zip libaio-dev && unzip -o /tmp/instantclient-basic-linux.x64-12.2.0.1.0.zip -d /usr/local/ \
     && unzip -o /tmp/instantclient-sdk-linux.x64-12.2.0.1.0.zip -d /usr/local/ \
     && unzip -o /tmp/instantclient-sqlplus-linux.x64-12.2.0.1.0.zip -d /usr/local/ \
     && ln -s /usr/local/instantclient_12_2 /usr/local/instantclient \
     && ln -s /usr/local/instantclient/libclntsh.so.12.1 /usr/local/instantclient/libclntsh.so \
     && ln -s /usr/local/instantclient/sqlplus /usr/bin/sqlplus \
     && echo 'export LD_LIBRARY_PATH="/usr/local/instantclient"' >> /root/.bashrc \
     && echo 'export ORACLE_HOME="/usr/local/instantclient"' >> /root/.bashrc \
     && echo 'umask 002' >> /root/.bashrc \
     && docker-php-ext-configure oci8 -with-oci8=instantclient,/usr/local/instantclient \
     && docker-php-ext-install oci8 

