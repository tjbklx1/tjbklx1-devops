yum_repo_release:
  pkg.installed:
    - source:
      - epel-release: http://mirrors.aliyun.com/epel/6/x86_64/epel-release-6-8.noarch.rpm
  - unless: rpm -qa | grep eple-release-6-8