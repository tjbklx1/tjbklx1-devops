include:
  - nginx.install
  
nginx-init:
  file.managed:
    - name: /etc/init.d/nginx
    - source: salt://nginx/files/nginx-init
    - mode: 755
    - user: root
    - group: root
  cmd.run:
    - name: chkconfig --add nginx
    - unless: chkconfig --list | grep nginx
    - required:
      - file: nginx-init

/usr/local/nginx/conf/nginx.conf:
  file.managed:
    - source: salt://nginx/files/nginx.conf
    - mode: 644
    - user: www
    - group: www
  
nginx-service:
  file.directory:
    - name: /usr/local/nginx/conf/vhost 
    - required:
      - cmd: nginx-source-install
  service.running:
    - name: nginx 
    - enabled: True
    - reload: True
    - required:
      - cmd: nginx-init
    - watch:
      - file /usr/local/nginx/conf/nginx.conf
