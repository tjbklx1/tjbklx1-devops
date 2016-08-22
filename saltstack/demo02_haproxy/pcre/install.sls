pcre-source-install:
  file.managed:
    - name: /usr/local/src/pcre-8.37.tar.gz
    - source: salt://pcre/files/pcre-8.37.tar.gz
    - mode: 755
    - user: root
    - group: root
  cmd.run:
    - name: cd /usr/local/src && tar zxf pcre-8.37.tar.gz && cd pcre-8.37 && ./configure --prefix=/usr/local/pcre && make && make install
    - unless: test -d /usr/local/pcre
    - required:
      - file: pcre-source-install
      