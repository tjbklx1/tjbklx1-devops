案例: 修改minion主机名称

##1 master删除key
###salt-key -d salt-client -y

    [root@master ~]# salt-key -L
    Accepted Keys:
    minion.hello.com
    Denied Keys:
    Unaccepted Keys:
    Rejected Keys:
    [root@master ~]# salt-key -d minion.hello.com -y
    Deleting the following keys:
    Accepted Keys:
    minion.hello.com
    Key for minion minion.hello.com deleted.
    [root@master ~]# salt-key -L
    Accepted Keys:
    Denied Keys:
    Unaccepted Keys:
    Rejected Keys:

##2 minion 修改主机名

    [root@minion ~]# cat /etc/hosts
    127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
    ::1         localhost localhost.localdomain localhost6 localhost6.localdomain6

    192.168.1.191 master.hello.com
    192.168.1.192 minion.abc.com
    [root@minion ~]# hostname minion.abc.com

##3 minion 删除 /etc/salt/moniom_id pki/

    [root@minion ~]# cd /etc/salt/
    [root@minion salt]# ls
    grains  minion  minion.d  minion_id  pki
    [root@minion salt]# cat minion_id
    minion.hello.com
    [root@minion salt]# ls -l pki/minion/
    total 12
    -rw-r--r-- 1 root root  451 May 13 11:32 minion_master.pub
    -r-------- 1 root root 1679 May 13 11:32 minion.pem
    -rw-r--r-- 1 root root  451 May 13 11:32 minion.pub
    [root@minion salt]# rm -rf minion_id pki

##4 minion restart

    [root@minion salt]# service salt-minion start
    Starting salt-minion daemon: already running
    [root@minion salt]# service salt-minion restart
    Stopping salt-minion daemon:                               [  OK  ]
    Starting salt-minion daemon:                               [  OK  ]


##5 master accept

    [root@master ~]# salt-key -L
    Accepted Keys:
    Denied Keys:
    Unaccepted Keys:
    minion.abc.com
    Rejected Keys:
    [root@master ~]# salt-key -a minion.abc.com
    The following keys are going to be accepted:
    Unaccepted Keys:
    minion.abc.com
    Proceed? [n/Y] y
    Key for minion minion.abc.com accepted.
    [root@master ~]# salt-key -L
    Accepted Keys:
    minion.abc.com
    Denied Keys:
    Unaccepted Keys:
    Rejected Keys:

##6 测试

        [root@master ~]# salt '*' test.ping
        minion.abc.com:
            True
 

more:
修改主机名称时,可以用salt更方便
查看  salt '*' cmd.run "grep salt /etc/hosts"
修改  salt '*' cmd.run "sed -i 's/40/47/' /etc/hosts"
查看  salt '*' cmd.run "grep salt /etc/hosts"
重启minion  salt '*' service.restart salt-minion

必要时候查看日志
tail /var/log/salt/minion
