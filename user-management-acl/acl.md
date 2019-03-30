# acl
access control list，主要目的是提供传统的属主，所属群组，其他人的读写执行权限之外的详细权限设置。
1. 检测是否支持acl：
dmesg|grep acl

2. getfacl
获取某个文件、目录的acl设置选项
3. setfacl
  1. setfacl -m u:liuhauzzo01:rx acl_test1  
    [liuhaozzu@centos7-1 ~]$ ll ./acl_test1  
    -rw-rwxr--+ 1 liuhaozzu liuhaozzu 0 Mar 30 21:57 ./acl_test1 # 权限列表处多了一个“+”  
  2. setfacl -m g:组名:rwx filename
  3. mask：有效权限：用户或用户组所设置的权限必须在mask所限制的范围内，才能生效。
  4. 默认情况下，文件夹下面的acl权限不会被继承，-d参数可以解决此问题  
    setfacl -m d:u:用户名:rx /srv/projecta

