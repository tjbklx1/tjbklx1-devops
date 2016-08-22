nginx

##大概的步骤:
为了获取nginx的配置文件
- yum -y install nginx

建立配置文件的保存目录,并保存配置文件

- mkdir -p /srv/salt/etc/nginx/conf.d
- cp /etc/nginx/nginx.conf /srv/salt/etc/nginx
- cp /etc/nginx/conf.d/default.conf /srv/salt/etc/nginx/conf.d 
- mkdir nginx/


	cat nginx/init.sls
    nginx:
      pkg:
        - installed
      service:
        - running
        - enable: True
        - reload: True
        - watch:
          - pkg: nginx
          - file: /etc/nginx/nginx.conf
          - file: /etc/nginx/conf.d/default.conf
    /etc/nginx/nginx.conf:
      file.managed:
        - source: salt://etc/nginx/nginx.conf
        - mode: 644
        - user: root
        - group: root
    /etc/nginx/conf.d/default.conf:
      file.managed:
        - source: salt://etc/nginx/conf.d/default.conf
        - mode: 644
        - user: root
        - group: root

调用:

	salt '*' state.sls nginx

注意:如果安装过程很慢，则　salt '*' state.sls nginx　会出现超时没有返回　但是event会返回
下面的两条命令就是验证安装的情况

    salt '*' cmd.run 'rpm -qa | grep nginx'
    salt '*' cmd.run 'netstat -lnt'

修改nginx的配置文件


    [root@master salt]# cat etc/nginx/conf.d/default.conf | grep default_server 
        listen       8080 default_server;
    
minion:  

	salt-call state.sls nginx




具体步骤


    [root@master salt]# yum -y install nginx
    Installed:
      nginx.x86_64 0:1.0.15-12.el6                                                                                                                               

    Dependency Installed:
      GeoIP.x86_64 0:1.6.5-1.el6                        GeoIP-GeoLite-data.noarch 0:2015.12-1.el6        GeoIP-GeoLite-data-extra.noarch 0:2015.12-1.el6       
      fontconfig.x86_64 0:2.8.0-5.el6                   freetype.x86_64 0:2.3.11-17.el6                  gd.x86_64 0:2.0.35-11.el6                             
      geoipupdate.x86_64 0:2.2.1-2.el6                  libX11.x86_64 0:1.6.3-2.el6                      libX11-common.noarch 0:1.6.3-2.el6                    
      libXau.x86_64 0:1.0.6-4.el6                       libXpm.x86_64 0:3.5.10-2.el6                     libjpeg-turbo.x86_64 0:1.2.1-3.el6_5                  
      libpng.x86_64 2:1.2.49-2.el6_7                    libxcb.x86_64 0:1.11-2.el6                       libxslt.x86_64 0:1.1.26-2.el6_3.1                     
      nginx-filesystem.noarch 0:1.0.15-12.el6           perl.x86_64 4:5.10.1-141.el6_7.1                 perl-Module-Pluggable.x86_64 1:3.90-141.el6_7.1       
      perl-Pod-Escapes.x86_64 1:1.04-141.el6_7.1        perl-Pod-Simple.x86_64 1:3.13-141.el6_7.1        perl-libs.x86_64 4:5.10.1-141.el6_7.1                 
      perl-version.x86_64 3:0.77-141.el6_7.1           

    Complete!
    [root@master salt]# mkdir -p /srv/salt/etc/nginx/conf.d 
    [root@master salt]# cp /etc/nginx/nginx.conf /srv/salt/etc/nginx
    [root@master salt]# cp /etc/nginx/conf.d/default.conf /srv/salt/etc/nginx/conf.d 
    [root@master salt]# mkdir nginx
    [root@master salt]# cat nginx/init.sls
    nginx:
      pkg:
        - installed
      service:
        - running
        - enable: True
        - reload: True
        - watch:
          - pkg: nginx
          - file: /etc/nginx/nginx.conf
          - file: /etc/nginx/conf.d/default.conf
    /etc/nginx/nginx.conf:
      file.managed:
        - source: salt://etc/nginx/nginx.conf
        - mode: 644
        - user: root
        - group: root
    /etc/nginx/conf.d/default.conf:
      file.managed:
        - source: salt://etc/nginx/conf.d/default.conf
        - mode: 644
        - user: root
        - group: root
    [root@master salt]#
    [root@master salt]# salt '*' state.sls nginx
    minion.abc.com:
    ----------
              ID: nginx
        Function: pkg.installed
          Result: True
         Comment: The following packages were installed/updated: nginx
         Started: 12:34:24.438359
        Duration: 165133.134 ms
         Changes:   
                  ----------
                  GeoIP:
                      ----------
                      new:
                          1.6.5-1.el6
                      old:
                  GeoIP-GeoLite-data:
                      ----------
                      new:
                          2015.12-1.el6
                      old:
                  GeoIP-GeoLite-data-extra:
                      ----------
                      new:
                          2015.12-1.el6
                      old:
                  fontconfig:
                      ----------
                      new:
                          2.8.0-5.el6
                      old:
                  freetype:
                      ----------
                      new:
                          2.3.11-17.el6
                      old:
                  gd:
                      ----------
                      new:
                          2.0.35-11.el6
                      old:
                  geoipupdate:
                      ----------
                      new:
                          2.2.1-2.el6
                      old:
                  libX11:
                      ----------
                      new:
                          1.6.3-2.el6
                      old:
                  libX11-common:
                      ----------
                      new:
                          1.6.3-2.el6
                      old:
                  libXau:
                      ----------
                      new:
                          1.0.6-4.el6
                      old:
                  libXpm:
                      ----------
                      new:
                          3.5.10-2.el6
                      old:
                  libjpeg-turbo:
                      ----------
                      new:
                          1.2.1-3.el6_5
                      old:
                  libpng:
                      ----------
                      new:
                          1.2.49-2.el6_7
                      old:
                  libxcb:
                      ----------
                      new:
                          1.11-2.el6
                      old:
                  libxslt:
                      ----------
                      new:
                          1.1.26-2.el6_3.1
                      old:
                  nginx:
                      ----------
                      new:
                          1.0.15-12.el6
                      old:
                  nginx-filesystem:
                      ----------
                      new:
                          1.0.15-12.el6
                      old:
                  perl:
                      ----------
                      new:
                          5.10.1-141.el6_7.1
                      old:
                  perl-Module-Pluggable:
                      ----------
                      new:
                          3.90-141.el6_7.1
                      old:
                  perl-Pod-Escapes:
                      ----------
                      new:
                          1.04-141.el6_7.1
                      old:
                  perl-Pod-Simple:
                      ----------
                      new:
                          3.13-141.el6_7.1
                      old:
                  perl-libs:
                      ----------
                      new:
                          5.10.1-141.el6_7.1
                      old:
                  perl-version:
                      ----------
                      new:
                          0.77-141.el6_7.1
                      old:
    ----------
              ID: /etc/nginx/nginx.conf
        Function: file.managed
          Result: True
         Comment: File /etc/nginx/nginx.conf is in the correct state
         Started: 12:37:09.584638
        Duration: 15.144 ms
         Changes:   
    ----------
              ID: /etc/nginx/conf.d/default.conf
        Function: file.managed
          Result: True
         Comment: File /etc/nginx/conf.d/default.conf is in the correct state
         Started: 12:37:09.599910
        Duration: 5.971 ms
         Changes:   
    ----------
              ID: nginx
        Function: service.running
          Result: True
         Comment: Service nginx has been enabled, and is running
         Started: 12:37:09.606161
        Duration: 273.734 ms
         Changes:   
                  ----------
                  nginx:
                      True

    Summary
    ------------
    Succeeded: 4 (changed=2)
    Failed:    0
    ------------
    Total states run:     4
    [root@master salt]# salt '*' cmd.run 'rpm -qa | grep nginx'
    minion.abc.com:
        nginx-1.0.15-12.el6.x86_64
        nginx-filesystem-1.0.15-12.el6.noarch
    [root@master salt]# salt '*' cmd.run 'netstat -lnt'
    minion.abc.com:
        Active Internet connections (only servers)
        Proto Recv-Q Send-Q Local Address               Foreign Address             State      
        tcp        0      0 0.0.0.0:80                  0.0.0.0:*                   LISTEN      
        tcp        0      0 0.0.0.0:22                  0.0.0.0:*                   LISTEN      
        tcp        0      0 127.0.0.1:25                0.0.0.0:*                   LISTEN      
        tcp        0      0 :::22                       :::*                        LISTEN      
        tcp        0      0 ::1:25                      :::*                        LISTEN
    [root@master salt]# 
    [root@master salt]# vi etc/nginx/conf.d/default.conf   修改参数 重新发起调用
    [root@master salt]# cat etc/nginx/conf.d/default.conf | grep default_server 
        listen       8080 default_server;



    minion: salt-call
    [root@minion salt]# salt-call state.sls nginx
    [INFO    ] Loading fresh modules for state activity
    [INFO    ] Fetching file from saltenv 'base', ** skipped ** latest already in cache 'salt://nginx/init.sls'
    [INFO    ] Running state [nginx] at time 12:43:46.208975
    [INFO    ] Executing state pkg.installed for nginx
    [INFO    ] Executing command "repoquery --plugins --queryformat '%{NAME}_|-%{VERSION}_|-%{RELEASE}_|-%{ARCH}_|-%{REPOID}' --all --pkgnarrow=installed" in directory '/root'
    [INFO    ] Package nginx is already installed.
    [INFO    ] Completed state [nginx] at time 12:43:46.603537
    [INFO    ] Running state [/etc/nginx/nginx.conf] at time 12:43:46.608108
    [INFO    ] Executing state file.managed for /etc/nginx/nginx.conf
    [INFO    ] File /etc/nginx/nginx.conf is in the correct state
    [INFO    ] Completed state [/etc/nginx/nginx.conf] at time 12:43:46.628747
    [INFO    ] Running state [/etc/nginx/conf.d/default.conf] at time 12:43:46.629383
    [INFO    ] Executing state file.managed for /etc/nginx/conf.d/default.conf
    [INFO    ] Fetching file from saltenv 'base', ** done ** 'etc/nginx/conf.d/default.conf'
    [INFO    ] File changed:
    ---  
    +++  
    @@ -2,7 +2,7 @@
     # The default server
     #
     server {
    -    listen       80 default_server;
    +    listen       8080 default_server;
         server_name  _;
     
         #charset koi8-r;

    [INFO    ] Completed state [/etc/nginx/conf.d/default.conf] at time 12:43:46.652231
    [INFO    ] Running state [nginx] at time 12:43:46.652737
    [INFO    ] Executing state service.running for nginx
    [INFO    ] Executing command '/sbin/service nginx status' in directory '/root'
    [INFO    ] Executing command '/sbin/chkconfig --list nginx' in directory '/root'
    [INFO    ] Executing command '/sbin/runlevel' in directory '/root'
    [INFO    ] Service nginx is already enabled, and is in the desired state
    [INFO    ] Completed state [nginx] at time 12:43:46.716825
    [INFO    ] Running state [nginx] at time 12:43:46.717108
    [INFO    ] Executing state service.mod_watch for nginx
    [INFO    ] Executing command '/sbin/service nginx status' in directory '/root'
    [INFO    ] Executing command '/sbin/service nginx reload' in directory '/root'
    [INFO    ] {'nginx': True}
    [INFO    ] Completed state [nginx] at time 12:43:46.806279
    local:
    ----------
              ID: nginx
        Function: pkg.installed
          Result: True
         Comment: Package nginx is already installed.
         Started: 12:43:46.208975
        Duration: 394.562 ms
         Changes:   
    ----------
              ID: /etc/nginx/nginx.conf
        Function: file.managed
          Result: True
         Comment: File /etc/nginx/nginx.conf is in the correct state
         Started: 12:43:46.608108
        Duration: 20.639 ms
         Changes:   
    ----------
              ID: /etc/nginx/conf.d/default.conf
        Function: file.managed
          Result: True
         Comment: File /etc/nginx/conf.d/default.conf updated
         Started: 12:43:46.629383
        Duration: 22.848 ms
         Changes:   
                  ----------
                  diff:
                      ---  
                      +++  
                      @@ -2,7 +2,7 @@
                       # The default server
                       #
                       server {
                      -    listen       80 default_server;
                      +    listen       8080 default_server;
                           server_name  _;
                       
                           #charset koi8-r;
    ----------
              ID: nginx
        Function: service.running
          Result: True
         Comment: Service reloaded
         Started: 12:43:46.717108
        Duration: 89.171 ms
         Changes:   
                  ----------
                  nginx:
                      True

    Summary
    ------------
    Succeeded: 4 (changed=2)
    Failed:    0
    ------------
    Total states run:     4
    [root@minion salt]# 



    [root@master salt]# salt '*' cmd.run 'netstat -lnt'
    minion.abc.com:
        Active Internet connections (only servers)
        Proto Recv-Q Send-Q Local Address               Foreign Address             State      
        tcp        0      0 0.0.0.0:8080                0.0.0.0:*                   LISTEN      
        tcp        0      0 0.0.0.0:22                  0.0.0.0:*                   LISTEN      
        tcp        0      0 127.0.0.1:25                0.0.0.0:*                   LISTEN      
        tcp        0      0 :::22                       :::*                        LISTEN      
        tcp        0      0 ::1:25                      :::*                        LISTEN
    [root@master salt]# 

