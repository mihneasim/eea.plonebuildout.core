#!/bin/bash

# Init file for Zope servers
#
# chkconfig: 2345 70 25
# description: Zope servers
#
# processname: zope

# source function library

RETVAL=0
SUCMD='su -s /bin/bash zope -c'
PREFIX='buildout_path'
INSTANCES=("www1" "www2" "www3" "www4" "www5" "www6" "www7" "www8")

start_all() {
    $SUCMD "$PREFIX/bin/zeoserver start"
    for name in "${INSTANCES[@]}"; do
        $SUCMD "$PREFIX/bin/$name start"
    done
    $SUCMD "$PREFIX/bin/poundctl start"
    $SUCMD "$PREFIX/bin/memcached start"

}

stop_all() {
    $SUCMD "$PREFIX/bin/memcached stop"
    $SUCMD "$PREFIX/bin/poundctl stop"
    for name in "${INSTANCES[@]}"; do
        $SUCMD "$PREFIX/bin/$name stop"
    done
    $SUCMD "$PREFIX/bin/zeoserver stop"
}

status_all() {
    echo -n "zeoserver: "
    $PREFIX/bin/zeoserver status
    for name in "${INSTANCES[@]}"; do
        echo -n "$name: "
        $PREFIX/bin/$name status
    done
    echo -n "pound: "
    $PREFIX/bin/poundctl status
    echo -n "memcached: "
    status memcached
    RETVAL=$?
}

case "$1" in
  start)
        start_all
        ;;
  stop)
        stop_all
        ;;
  status)
        status_all
        ;;
  restart)
        stop_all
        start_all
        ;;
  *)
        echo "Usage: $0 {start|stop|status|restart}"
        RETVAL=1
esac
exit $RETVAL
