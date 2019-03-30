# useradd
1. 创建普通账号
useradd -u 1001 -g liuhaozzu liuhaozzu01
2. 创建系统账号，uid在1-1000之间，且由于系统账号主要用来执行系统权限设置，所以不会默认创建家目录
useradd -r systemaccount
3. useradd -D #查询默认配置
  1. SKEL=/etc/skel #用户家目录参考基准目录，新增用户的家目录的内容均是由该文件下的内容复制过去的

4. 密码相关配置：/etc/login.defs
### useradd 命令会参考 /etc/default/useradd  /etc/login.defs  /etc/skel/* 这些文件

# passwd
-n 后面跟天数，shadow第四位，多久不可以修改密码
-x 后面跟天数，shadow第5位，多久内必须修改密码
-w 后面跟天数，shadow第6位，过期前的警告天数
-l 后面跟 日期，shadow第7位，密码失效日期

1. root 可以修改任何用户的密码，而不需要知道该用户的当前密码
2. passwd -S liuhaozzu # 列出密码相关参数
3. passwd -l liuhaozzu # 锁定该账户，暂时无法登陆
4. passwd -u liuhaozzu # 解锁

