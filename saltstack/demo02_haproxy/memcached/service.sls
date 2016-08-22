include:
  - memcached.install
  - user.www
  
memchached-service:
  cmd.run:
    - name:/user/local/memcached/bin/memcached -d -m 128 -p 11211 -c 8096 -u www
    - unless: netstat -ntlp | grep 11211
    -required:
      - cmd:memcached-source-install
      - user: www-user-group
