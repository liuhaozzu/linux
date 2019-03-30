## cut
cut -d ':' -f 3,5 //将文本以：分隔，取第三个，第五个片段  
cut -c 12- //输出第12个字符以后的所有字符串  
cut -c 12-20 //输出第12到20个字符   

## grep 基于LANG=C语系
[:alnum:] 代表大小写英文字符和数字，0-9A-Za-z  
[:alpha:] 代表任何大小写英文字符a-zA-Z  
[:blank:] 代表空格与tab键  
[:cntrl:] 代表键盘上面的 控制按键， 包括 CR、LF Tab Del等  
[:digit:] 代表数字 0-9  
[:graph:] 除了空格符（空格键 与 tab键）外的其他所有按键  
[:lower:] 代表小写字符 a-z  
[:print:] 代表任何可以被打印出来的字符  
[:punct:] 代表标点符号  
[:upper:] 代表大写字符A-Z   
[:space:] 任何会产生空白的字符，包括空格键，tab，CR等  
[:xdigit:] 代表十六进制的数字类型，因此包括0-9，A-F，a-f  


grep -c //输出匹配字符串的行数  
grep -i //忽略大小写  
grep -v //反向选取  
grep -n //顺便输出行号  
grep -A3 -B6 //列出前3行，后六行
grep -C10 //列出前后10行

[liuhaozzu@centos7-1 ~]$ grep '[^t]is' ./regular_text.txt # is前不包含t的行  
[liuhaozzu@centos7-1 ~]$ grep '[[:upper:]]' ./regular_text.txt  
grep -A3 -B6 //列出前3行，后六行  
grep -C10 //列出前后10行  
tr -d SET1 //删除指定支付SET1  
tr '[a-z]' '[A-Z]' //将所有的小写字符，替换为大写字符  
-rw-rw-r-- 1 liuhaozzu liuhaozzu  1024 Mar 29 22:32 rootfilesplitaa  
-rw-rw-r-- 1 liuhaozzu liuhaozzu   378 Mar 29 22:32 rootfilesplitab  
split -l 10 file PREFIX # 以行数划分文件  

### regular express
go* # 代表0出现0次或多次  
go{1,3}gle #o出现1-3次  


## sort
sort -t ':' -k 3 //以：分隔，以第三栏排序 ，默认以文字形式排序  
sort -t ':' -k 3 -rn //-r逆序 -n以数字来排序  
sort -u //即uniq，相同的数据中，仅出现一行代表  

## uniq
uniq -c //进行计数  
uniq -i //忽略大小写

## wc
wc -l //仅列出行数   

[liuhaozzu@centos7-1 ~]$ cat catfile
nihao  
world  
hello hello hello  
hello  

[liuhaozzu@centos7-1 ~]$ wc ./catfile  
 4  6 36 ./catfile #默认输出行 字数 字符数

## tee 双向重定向
last |tee -a last.file|cut -d ' ' -f1 //将last的输出存一份到文件中，并且向管道输出

## tr 
可以用来删除一段信息当中的文字，或是进行文字信息的替换    
tr -d SET1 //删除指定支付SET1  
tr '[a-z]' '[A-Z]' //将所有的小写字符，替换为大写字符  

## join
处理两个文件之间的数据：有相同数据的那一行，才将它加在一起  
join -t ':' -i -1 3 /etc/passwd -2 3 /etc/shadow //两个文件均以':'分隔；忽略大小写；-1 3代表第一文档以第三栏比较；-2 3：代表第二个文件以第三栏比较

## split 拆分文件
[liuhaozzu@centos7-1 ~]$ cat rootfile |split -b 1k - rootfilesplit #以b,k,m划分文件， - 代表标准输出  
[liuhaozzu@centos7-1 ~]$ ll|grep split # 划分结果  
-rw-rw-r-- 1 liuhaozzu liuhaozzu  1024 Mar 29 22:32 rootfilesplitaa  
-rw-rw-r-- 1 liuhaozzu liuhaozzu   378 Mar 29 22:32 rootfilesplitab  
split -l 10 file PREFIX # 以行数划分文件

## [-]减号的用途
在管道中代表标准输出  

