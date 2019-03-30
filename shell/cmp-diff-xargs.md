# diff
对比两个文件之间的差异，以行为单位进行对比，一般是在ASC2纯文本文件上做对比  
[liuhaozzu@centos7-1 testpw]$ diff passwd passwd.new  
4d3  # 表示左边第四行被删除（d）了，基准是右边第三行  
< adm:x:3:4:adm:/var/adm:/sbin/nologin  # < 列出左边（<）文件被删除的那一行  
6c5  
< sync:x:5:0:sync:/sbin:/bin/sync  
---  
> no six line  # 右边（>）文件第五行的内容  

#cmp
对比文件，以字节为单位对比

#patch
1. 制作patch文件
[liuhaozzu@centos7-1 testpw]$ diff -Naur passwd passwd.new > passwd.patch  
[liuhaozzu@centos7-1 testpw]$ ll  
total 12  
-rw-r--r-- 1 liuhaozzu liuhaozzu 2395 Mar 30 10:40 passwd 
-rw-rw-r-- 1 liuhaozzu liuhaozzu 2338 Mar 30 10:45 passwd.new   
-rw-rw-r-- 1 liuhaozzu liuhaozzu  476 Mar 30 10:57 passwd.patch  
2. 更新旧文件
[liuhaozzu@centos7-1 testpw]$ patch -p0 <passwd.patch  
patching file passwd  
# -p 后面接数字，表示取消几层目录，-p0表示在对比新旧版本的数据时在同一目录
# -R 代表还原，将新的文件还原成原来旧的版本
3. 还原旧文件
[liuhaozzu@centos7-1 testpw]$ patch -R -p0 < passwd.patch  
patching file passwd  

# xargs
产生某个命令的参数  
[liuhaozzu@centos7-1 testpw]$ cut -d ':' -f 1 /etc/passwd|head -3|xargs -n1 id  
-e end of file,xargs接收到这个字符时，就会停止执行
-n 后面接数字，表示需要几个参数
-p 执行命令时，询问使用者的意思
