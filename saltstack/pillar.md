#pillar

##注意事项

打开master 中 pillar的配置

	vi /etc/salt/master
    pillar_roots:
      base:
        - /srv/pillar

 mkdir /srv/pillar
 /srv/pillar/top.sls  这个文件是必须的,state中top.sls是可选的.


    [root@master ~]# salt '*' pillar.items
    minion.hello.com:
        ----------

    [root@master ~]# mkdir /srv/pillar
    [root@master ~]# cat /srv/pillar/top.sls
    base:
      '*':
        - packages 
        - services 


    [root@master ~]# cat /srv/pillar/packages.sls
    zabbix:
      package-name: zabbix
      version: 2.2.4
    [root@master ~]# cat /srv/pillar/services.sls
    zabbix:
      port: 10050
      user: admin

    [root@master ~]# salt '*' pillar.items
    minion.hello.com:
        ----------
        zabbix:
            ----------
            package-name:
                zabbix
            port:
                10050
            user:
                admin
            version:
                2.2.4

    [root@master ~]# salt 'minion.hello.com' sys.list_functions pillar
    minion.hello.com:
        - pillar.data
        - pillar.ext
        - pillar.get
        - pillar.item
        - pillar.items
        - pillar.raw
    [root@master ~]# 
    [root@master ~]# salt 'minion.hello.com' pillar.items zabbix
    minion.hello.com:
        ----------
        zabbix:
            ----------
            package-name:
                zabbix
            port:
                10050
            user:
                admin
            version:
                2.2.4


##更复杂的pillar

    [root@master ~]# mkdir /srv/pillar/users/
    [root@master ~]# cat /srv/pillar/top.sls
    base:
      '*':
        - packages 
        - services 
        - users

    [root@master ~]# cat /srv/pillar/users/init.sls
    users:
      thatch: 1000  
      shouse: 1001  
      utahdave: 1002  
      redbeard: 1003
    [root@master ~]# salt 'minion.hello.com' pillar.items users
    minion.hello.com:
        ----------
        users:
            ----------
            redbeard:
                1003
            shouse:
                1001
            thatch:
                1000
            utahdave:
                1002

##定时任务:schedule

###下面的实验依赖于nginx

    schedule:
      highstate:
        function: state.higstate
        minutes: 1

    salt '*' saltutil.refresh_pillar

###实验过程

    [root@master pillar]# cat top.sls
    base:
      '*':
        - nginx

    mkdir nginx
    
    [root@master pillar]# cat nginx/init.sls
    schedule:
      nginx:
      function: state.sls
      minutes: 1
      args:
        - 'nginx'
  
  
查看pillar变量 salt '*' pillar.data 

    [root@master pillar]# salt '*' pillar.data 
    minion.abc.com:
        ----------
        schedule:
            ----------
            args:
                - nginx
            function:
                state.sls
            minutes:
                1
            nginx:
                None

刷新数据  salt '*' saltutil.refresh_pillar

    [root@master pillar]# salt '*' saltutil.refresh_pillar
    minion.abc.com:
        True

更改端口 查看定时任务的执行情况

    [root@master pillar]# cat /srv/salt/etc/nginx/conf.d/default.conf | grep default_server 
        listen       80 default_server;

更新成功

    [root@master pillar]# salt '*' cmd.run 'netstat -lnt'
    minion.abc.com:
        Active Internet connections (only servers)
        Proto Recv-Q Send-Q Local Address               Foreign Address             State      
        tcp        0      0 0.0.0.0:80                  0.0.0.0:*                   LISTEN      
        tcp        0      0 0.0.0.0:22                  0.0.0.0:*                   LISTEN      
        tcp        0      0 127.0.0.1:25                0.0.0.0:*                   LISTEN      
        tcp        0      0 :::22                       :::*                        LISTEN      
        tcp        0      0 ::1:25                      :::*                        LISTEN

