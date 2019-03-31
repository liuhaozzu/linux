# SELinux
Secuity Enhanced Linux：通过MAC的方式来管理进程，控制的主体是进程。而且目标则是该进程能否读取的【文件资源】
1. 系统出现问题的原因大部分都在于【内部员工的资源误用】，实际由外部发动的攻击反而没有这么严重。
2. SELinux是在进行进程，文件等详细权限配置时依据的一个内核模块。由于启动网络服务的也是进程，因此刚好也是能够控制网络服务能否读写系统资源的一道关卡。
3. 传统文件权限与账号关系：自主访问控制（DAC）的不足：  
      1. root 具有最高的权限：如果某个具有root权限的进程被挟持，那么该挟持着就具有root权限了  
      2. 用户可以获取进程来修改文件资源的访问权限。  
4. 以策略规则制定特定进程读取特定文件：强制访问控制（MAC）
  1. 控制的【主体】变成了【进程】而不是【用户】

5. 获取目前SELinux模式 
[root@centos7-1 ~]# getenforce  
Disabled  
# SELinux规则管理
1. getsebool -a  # SELinux各个规则的布尔值查询
2. 安装相应工具：yum install -y setools-console-*
3. seinfo #列出SELinux在此策略下的统计状态
4. sesearch -A -s crond_t|grep spool # 找出crond_t这个主体进程能够读取的文件SELinux类型
      1. [root@centos7-1 ~]# sesearch -A -s crond_t|grep spool  
         allow crond_t cron_spool_t : dir { ioctl read write getattr lock add_name remove_name search open } ;  
         allow crond_t system_cron_spool_t : file { ioctl read write create getattr setattr lock append unlink link rename open } ;  
         allow crond_t cron_spool_t : file { ioctl read write create getattr setattr lock append unlink link rename open } ;  
5. ll -Z /etc/cron.d/checktime # 列出文件的SELinux配置
6. 
      1. [root@centos7-1 ~]# semanage boolean -l|grep httpd_enable_homedirs
httpd_enable_homedirs          (off  ,  off)  Allow httpd to enable homedirs
      2. setsebool -P httpd_enable_homedirs # 修改SELinux规则的布尔值 # -P直接将设置写入配置文件，该设置信息未来会生效。
      3. getsebool httpd_enable_homedirs
     
# SELinux安全上下文的修改
1. chcon 手动修改文件的SELinux类型
      [root@centos7-1 ~]# ll -Z /etc/hosts  
      -rw-r--r--. root root system_u:object_r:net_conf_t:s0  /etc/hosts  
      [root@centos7-1 ~]# chcon -v -t net_conf_t /etc/cron.d/checktime  
      changing security context of ‘/etc/cron.d/checktime’  
      [root@centos7-1 ~]#  
2. 查询文件的默认SELinux类型
      [root@centos7-1 ~]# semanage fcontext -l |grep -E '^/etc$ |^/etc/cron'
      /etc/cron.daily(/.*)?                              all files          system_u:object_r:bin_t:s0
      /etc/cron.weekly(/.*)?                             all files          system_u:object_r:bin_t:s0
      /etc/cron.hourly(/.*)?                             all files          system_u:object_r:bin_t:s0

3. 创建用例文件
      [root@centos7-1 ~]# mkdir /srv/mycron
      [root@centos7-1 ~]# ll -Z /srv/mycron/
      drwxr-xr-x. root root unconfined_u:object_r:var_t:s0   .
      drwxr-xr-x. root root system_u:object_r:var_t:s0       ..
      [root@centos7-1 ~]# cp /etc/cron.d/checktime /srv/mycron/
      [root@centos7-1 ~]# ll -dZ /srv/mycron /srv/mycron/checktime
      drwxr-xr-x. root root unconfined_u:object_r:var_t:s0   /srv/mycron
      -rw-r--r--. root root unconfined_u:object_r:var_t:s0   /srv/mycron/checktime
4. SELinux权限来源及修改
      [root@centos7-1 ~]# semanage fcontext -l |grep '^/srv'|head -1
      /srv/.*        all files          system_u:object_r:var_t:s0
      [root@centos7-1 ~]# semanage fcontext -a -t system_cron_spool_t "/srv/mycron(/.*)?"
      [root@centos7-1 ~]# semanage fcontext -l |grep '^/srv/mycron'
      /srv/mycron(/.*)? all files          system_u:object_r:system_cron_spool_t:s0
