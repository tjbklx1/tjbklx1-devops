job

[root@master salt]# salt 'minion.hello.com' cmd.run 'sleep 100;whoami'
^CExiting on Ctrl-C
This job's jid is:
20160601152123851846
The minions may not have all finished running and any remaining minions will return upon completion. To look up the return data for this job later run:
salt-run jobs.lookup_jid 20160601152123851846
[root@master salt]# 
[root@master salt]# salt-run jobs.lookup_jid 20160601152123851846
[root@master salt]# salt-run jobs.list_job 20160601152123851846
Arguments:
    - sleep 100;whoami
Function:
    cmd.run
Minions:
    - minion.hello.com
Result:
    ----------
StartTime:
    2016, Jun 01 15:21:23.851846
Target:
    minion.hello.com
Target-type:
    glob
User:
    root
jid:
    20160601152123851846


[root@master salt]# salt '*' sys.doc saltutil | grep job
'saltutil.find_cached_job:'
    Return the data for a specific cached job id
        salt '*' saltutil.find_cached_job <job id>
'saltutil.find_job:'
    Return the data for a specific job id
        salt '*' saltutil.find_job <job id>
'saltutil.kill_job:'
    Sends a kill signal (SIGKILL 9) to the named salt job's process
        salt '*' saltutil.kill_job <job id>
        salt '*' saltutil.runner jobs.list_jobs
'saltutil.signal_job:'
    Sends a signal to the named salt job's process
        salt '*' saltutil.signal_job <job id> 15
'saltutil.term_job:'
    Sends a termination signal (SIGTERM 15) to the named salt job's process
        salt '*' saltutil.term_job <job id>





[root@master salt]# salt 'minion.hello.com' cmd.run 'sleep 100;whoami'


^CExiting on Ctrl-C
This job's jid is:
20160601152432623259
The minions may not have all finished running and any remaining minions will return upon completion. To look up the return data for this job later run:
salt-run jobs.lookup_jid 20160601152432623259
[root@master salt]# 
[root@master salt]# 
[root@master salt]# 
[root@master salt]# salt 'minion.hello.com' saltutil.find_job 20160601152432623259
minion.hello.com:
    ----------
    arg:
        - sleep 100;whoami
    fun:
        cmd.run
    jid:
        20160601152432623259
    pid:
        4767
    ret:
    tgt:
        minion.hello.com
    tgt_type:
        glob
    user:
        root
[root@master salt]# salt 'minion.hello.com' saltutil.kill_job 20160601152432623259
minion.hello.com:
    Signal 9 sent to job 20160601152432623259 at pid 4767
[root@master salt]# salt 'minion.hello.com' saltutil.find_job 20160601152432623259
minion.hello.com:
    ----------

