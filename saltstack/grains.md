grains


    [root@master ~]# salt 'minion*' sys.list_functions grains
    minion.hello.com:
        - grains.append
        - grains.delval
        - grains.filter_by
        - grains.get
        - grains.get_or_set_hash
        - grains.has_value
        - grains.item
        - grains.items
        - grains.ls
        - grains.remove
        - grains.setval
        - grains.setvals
    
查看命令grains的文档

    [root@master ~]# salt 'minion*' sys.doc grains

查看grains
- salt 'minion*' grains.ls
- salt 'minion*' grains.items
- salt 'minion*' grains.item os
- salt 'minion*' grains.item shell
- salt -G 'os:CentOS' test.ping
- salt -G 'cpuarch:x86_64' grains.item num_cpus


    [root@master salt]# salt 'minion*' grains.item shell
    minion.abc.com:
        ----------
        shell:
            /bin/sh
    [root@master salt]# salt 'minion*' grains.item os
    minion.abc.com:
        ----------
        os:
            CentOS
    [root@master salt]# 
    [root@master salt]# salt -G 'os:CentOS' test.ping
    minion.abc.com:
        True
    [root@master salt]# salt -G 'cpuarch:x86_64' grains.item num_cpus
    minion.abc.com:
        ----------
        num_cpus:
            1
        

minion配置并重启

    [root@minion ~]# vi /etc/salt/minion
    default_include: minion.d/*.conf

    [root@minion ~]# cat /etc/salt/minion.d/grains.conf 
    grains:
      roles:
        - webserver
        - memcache
      deployment: datacenter4
      cabinet: 13
      cab_u: 14-15
      
    [root@minion ~]# service salt-minion restart
    Stopping salt-minion daemon:                               [  OK  ]
    Starting salt-minion daemon:                               [  OK  ]


master查询

    [root@master ~]# salt 'minion.hello.com' grains.item roles
    minion.hello.com:
        ----------
        roles:
            - webserver
            - memcache
    [root@master ~]# 
    [root@master ~]# salt 'minion.hello.com' grains.item deployment
    minion.hello.com:
        ----------
        deployment:
            datacenter4
     
    [root@master ~]# salt 'minion.hello.com' grains.append saltbook 'varycool'
    minion.hello.com:
        ----------
        saltbook:
            - varycool
    [root@master ~]# salt 'minion.hello.com' grains.item saltbook
    minion.hello.com:
        ----------
        saltbook:
            - varycool

    [root@master ~]# salt 'minion.hello.com' grains.setvals "{'salt':'good','book':'cool'}"
    minion.hello.com:
        ----------
        book:
            cool
        salt:
            good
    [root@master ~]# salt 'minion.hello.com' grains.item salt
    minion.hello.com:
        ----------
        salt:
            good
    [root@master ~]# salt 'minion.hello.com' grains.item book
    minion.hello.com:
        ----------
        book:
            cool
            