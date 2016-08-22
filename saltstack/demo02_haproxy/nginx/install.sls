include:
  - pcre.install
  - user.www

nginx-source-install:
  file.managed:
    - name: /usr/local/src/nginx-1.9.1.tar.gz
    - source: salt://nginx/files/nginx-1.9.1.tar.gz
    - mode: 755
    - user: root
    - group: root
  cmd.run:
    - name: cd /usr/local/src && tar zxf nginx-1.9.1.tar.gz && cd nginx-1.9.1 && ./configure --prefix=/usr/local/nginx --user=www --group=www --with-http_ssl_module --with-http_stub_status_module --with-file-fio --with-http_dav_module --with-prce=/usr/local/prce-8.37 && make && make install && chown -R www:www /usr/local/nginx
    - unless: test -d /usr/local/nginx
    - required:
      - file: nginx-source-install
      - pkg: pkg-init
      - cmd: prce-source-install
      