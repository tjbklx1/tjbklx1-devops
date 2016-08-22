module

[root@master ~]# salt '*' sys.list_modules
minion.hello.com:
    - acl
    - aliases
    - alternatives
    - archive
    - artifactory
    - blockdev
    - bridge
    - btrfs
    - buildout
    - cloud
    - cmd
    - composer
    - config
    - container_resource
    - cp
    - cron
    - data
    - defaults
    - devmap
    - disk
    - django
    - dnsmasq
    - dnsutil
    - drbd
    - elasticsearch
    - environ
    - etcd
    - event
    - extfs
    - file
    - gem
    - genesis
    - grains
    - group
    - grub
    - hashutil
    - hg
    - hipchat
    - hosts
    - http
    - img
    - incron
    - ini
    - introspect
    - ip
    - iptables
    - jboss7
    - jboss7_cli
    - key
    - kmod
    - locale
    - locate
    - logrotate
    - lowpkg
    - lvm
    - match
    - mine
    - modjk
    - mount
    - network
    - openstack_config
    - pagerduty
    - pillar
    - pip
    - pkg
    - pkg_resource
    - postfix
    - publish
    - pyenv
    - raid
    - random
    - random_org
    - rbenv
    - ret
    - rsync
    - runit
    - rvm
    - s3
    - saltutil
    - schedule
    - scsi
    - sdb
    - seed
    - serverdensity_device
    - service
    - shadow
    - slack
    - smtp
    - sqlite3
    - ssh
    - state
    - status
    - supervisord
    - sys
    - sysctl
    - syslog_ng
    - system
    - test
    - timezone
    - user
    - vbox_guest
    - virtualenv
    - xfs
[root@master ~]# 

[root@master ~]# salt '*' sys.list_functions cmd
minion.hello.com:
    - cmd.exec_code
    - cmd.exec_code_all
    - cmd.has_exec
    - cmd.retcode
    - cmd.run
    - cmd.run_all
    - cmd.run_chroot
    - cmd.run_stderr
    - cmd.run_stdout
    - cmd.script
    - cmd.script_retcode
    - cmd.shell
    - cmd.shells
    - cmd.tty
    - cmd.which
    - cmd.which_bin
[root@master ~]# 
[root@master ~]# 
[root@master ~]# salt '*' sys.list_functions test
minion.hello.com:
    - test.arg
    - test.arg_repr
    - test.arg_type
    - test.assertion
    - test.attr_call
    - test.collatz
    - test.conf_test
    - test.cross_test
    - test.echo
    - test.exception
    - test.fib
    - test.get_opts
    - test.kwarg
    - test.module_report
    - test.not_loaded
    - test.opts_pkg
    - test.outputter
    - test.ping
    - test.provider
    - test.providers
    - test.rand_sleep
    - test.rand_str
    - test.retcode
    - test.sleep
    - test.stack
    - test.try_
    - test.tty
    - test.version
    - test.versions_information
    - test.versions_report


[root@master ~]# salt '*' sys.doc cmd

[root@master ~]# salt 'minion.hello.com' test.echo,cmd.run,service.status saltbook,hostname,salt-master
minion.hello.com:
    ----------
    cmd.run:
        minion.hello.com
    service.status:
        False
    test.echo:
        saltbook