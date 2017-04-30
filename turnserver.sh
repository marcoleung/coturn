#!/bin/bash

if [ -z $SKIP_AUTO_IP ] && [ -z $EXTERNAL_IP ]
then
    if [ ! -z USE_IPV4 ]
    then
        EXTERNAL_IP=`curl -4 icanhazip.com 2> /dev/null`
    else
        EXTERNAL_IP=`curl icanhazip.com 2> /dev/null`
    fi
fi

if [ -z $PORT ]
then
    PORT=3478
fi

if [ ! -e /tmp/turnserver.configured ]
then
    if [ -z $SKIP_AUTO_IP ]
    then
        echo external-ip=$EXTERNAL_IP > /etc/turnserver.conf
    fi
    echo listening-port=$PORT >> /etc/turnserver.conf

    if [ ! -z $LISTEN_ON_PUBLIC_IP ]
    then
        echo listening-ip=$EXTERNAL_IP >> /etc/turnserver.conf
    fi
    
    #extra
    if [ -z $MIN_PORT ]
    then
        echo min-port=$MIN_PORT >> /etc/turnserver.conf
    else
        echo min-port=65500 >> /etc/turnserver.conf
    fi
    
    if [ -z $MAX_PORT ]
    then
        echo man-port=$MAX_PORT >> /etc/turnserver.conf
    else
        echo man-port=65534 >> /etc/turnserver.conf
    fi    
    
    if [ ! -z $PROD ]
    then
        echo verbose >> /etc/turnserver.conf
    fi
    
    if [ -z $MONGO_HOST ]
    then
        echo mongo-userdb=\"mongodb://$MONGO_HOST:27017/coturn\" >> /etc/turnserver.conf
    fi
    
    echo relay-ip=$EXTERNAL_IP >> /etc/turnserver.conf
    
    echo relay-threads=5 >> /etc/turnserver.conf
    echo lt-cred-mech >> /etc/turnserver.conf
    echo fingerprint >> /etc/turnserver.conf
    echo realm=pano >> /etc/turnserver.conf
    echo max-bps=100000 >> /etc/turnserver.conf
    echo log-file=stdout >> /etc/turnserver.conf
    echo secure-stun >> /etc/turnserver.conf

    touch /tmp/turnserver.configured
fi

exec /usr/bin/turnserver >>/var/log/turnserver.log 2>&1
