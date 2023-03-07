#!/bin/bash

/usr/sbin/service apache2 start
/usr/sbin/service mariadb start
/usr/sbin/service php8.1-fpm start
/usr/sbin/service apache-htcacheclean start
/usr/sbin/service ntp start
/usr/sbin/service rsync start
/usr/sbin/service postfix start
/usr/sbin/service cbd start
/usr/sbin/service centengine start
/usr/sbin/service gorgoned start
/usr/sbin/service centreontrapd start
/usr/sbin/service snmpd start
/usr/sbin/service snmptrapd start
/bin/bash

