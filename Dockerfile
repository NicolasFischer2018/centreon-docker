FROM debian:bullseye-slim

MAINTAINER Nicolas FISCHER

RUN apt-get update && \
	apt-get install -y locales && \
	apt-get install -y lsb-release ca-certificates apt-transport-https software-properties-common wget gnupg2 curl sudo apt-utils postfix mailutils && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	localedef -i fr_FR -c -f UTF-8 -A /usr/share/locale/locale.alias fr_FR.UTF-8

RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/sury-php.list
RUN wget -O- https://packages.sury.org/php/apt.gpg | gpg --dearmor | tee /etc/apt/trusted.gpg.d/php.gpg  > /dev/null 2>&1
RUN curl -LsS https://r.mariadb.com/downloads/mariadb_repo_setup | sudo bash -s -- --os-type=debian --os-version=11 --mariadb-server-version="mariadb-10.5"
RUN echo "deb https://apt.centreon.com/repository/22.10/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/centreon.list
RUN wget -O- https://apt-key.centreon.com | gpg --dearmor | tee /etc/apt/trusted.gpg.d/centreon.gpg > /dev/null 2>&1

ENV LANG fr_FR.utf8
ENV TZ="Europe/Paris"

RUN apt-get update && \
	apt-get install -y centreon && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
	apt-get install -y -o Dpkg::Options::="--force-overwrite" centreon-plugin* monitoring-plugins && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*
	
EXPOSE 80
EXPOSE 443

COPY start.sh ./start.sh
COPY centengine /etc/init.d/centengine
COPY cbd /etc/init.d/cbd
COPY centreontrapd /etc/init.d/centreontrapd
COPY gorgoned /etc/init.d/gorgoned

RUN chmod 755 ./start.sh
RUN chmod 755 /etc/init.d/centengine
RUN chmod 755 /etc/init.d/cbd
RUN chmod 755 /etc/init.d/centreontrapd
RUN chmod 755 /etc/init.d/gorgoned
RUN touch /var/log/centreon-engine/retention.dat
RUN chown www-data:www-data /etc/centreon-broker/*
RUN chown www-data:www-data /etc/centreon-engine/*

CMD ./start.sh
