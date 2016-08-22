zabbix-agent:
  pkg.installed:
    - name zabbix22-agent
    
  file.managed:
    - name: /etc/zabbix_agentd.conf
    - source: salt://zabbix/files/zabbix_agentd.conf
    - template: jinja
    - defaults: Server:{{ pillar['zabbix-agent']['Zabbix-Server']}}
    - require:
      - pkg: zabbix-agent
  
  service.running:
    - enabled:True
    - watch:
      - pkg: zabbix-agent
      - file: zabbix-agent

zabbix_agentd.conf.d:
  file.directory:
    - name:/etc/zabbix_agentd.conf.d
    - watch_in:
      - service: zabbix-agent
    - require:
      - pkg: zabbix-agent
      - file: zabbix-agent