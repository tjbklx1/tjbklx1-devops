mkdir /srv/salt/prod/pkg -p
mkdir /srv/salt/prod/haproxy/files -p
mkdir /srv/salt/prod/keepalived/files -p

cd /usr/local/src
cp haproxy-1.5.3.tar.gz /srv/salt/prod/haproxy/files
tar zxf haproxy-1.5.3.tar.gz
cd /usr/local/src/haproxy-1.5.3/examples
sed -i 's/\/usr\/sbin\/'\$BASENAME'/\usr\/local\/haproxy\/sbin\/'\$BASENAME'/g' haproxy.init
cp haproxy.init /srv/salt/prod/haproxy/files


salt '*' state.highstate test=True
salt '*' state.highstate


cd /usr/local/src
wget http://www.keepalived.org/software/keepalived-1.2.17.tar.gz

cp keepalived-1.2.17.tar.gz /srv/salt/prod/keepalived/files
tar zxf keepalived-1.2.17.tar.gz
cd keepalived-1.2.17
cp keepalived/etc/init.d/keepalived.init /srv/salt/prod/keepalived/files
cp keepalived/etc/init.d/keepalived.sysconfig /srv/salt/prod/keepalived/files

salt '*' state.highstate test=True
salt '*' state.highstate



mkdir /srv/salt/prod/libevent/files -p
mkdir /srv/salt/prod/memcached/files -p
mkdir /srv/salt/prod/user


cd /srv/salt/prod/libevent/files
wget 



cd /usr/local/src
wget http:/www.memcached.org/files/memcached-1.4.24.tar.gz
cp memcached-1.4.24.tar.gz /srv/salt/prod/memcached/files/

nginx

mkdir /srv/salt/prod/pcre/files -p
mkdir /srv/salt/prod/nginx/files -p
mkdir /srv/salt/prod/php/files -p

cd /usr/local/src/
wget

