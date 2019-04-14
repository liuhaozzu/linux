# sed
文本替换 删除 新增 选取特定行  
1. sed [-nefr] [operation]  
-n 安静模式，只输出经过sed处理的那一行  
-e 直接在命令行模式上进行sed操作  
-f 直接将sed的操作写在一个文件内  
-r 使用扩展型正则  
-i 直接修改读取的文件内容，而不是由屏幕输出  
n1,n2 :一般代表选择操作的行，
function：
1. a 新增 
2. c 替换 替换选择行
3. d 删除
4. i 插入
5. p 打印选择行
6. s 替换

## 用例
1. [liuhaozzu@centos7-1 ~]$ nl ./passwd |sed '2,5d' # 删除2-5行
2. [liuhaozzu@centos7-1 ~]$ nl ./passwd |sed '2,$d' # $代表最后一行
3. sed '2,5c 替换文本'
4. sed '2,5p' #打印第2到第5行
5. set 's/要被替换的字符/新字符/g'
6. [liuhaozzu@centos7-1 ~]$ /sbin/ifconfig eth1|grep inet|sed 's/^.*inet//g'| sed 's/ *netmask.*$//g' # 找出ip
7. sed -i 's/\.$/\!/g' regular_express.txt # 若行尾为. ,则替换为!

### 常用sed命令
/pattern/p 打印匹配pattern的行  
/pattern/d 删除匹配pattern的行  
/pattern/s/pattern1/pattern2/ 查找符合pattern的行，将该行***第一个***匹配pattern1的字符串替换为pattern2  
/pattern/s/pattern1/pattern2/g 查找符合pattern的行，将该行***所有***匹配pattern1的字符串替换为pattern2  
1. sed 's/bc/-&-/' testfile #pattern2中的&表示原文件的当前行中与pattern1相匹配的字符串
2. sed 's/\([0-9]\)\([0-9]\)/-\1-~\2~/' testfile # pattern2中的\1表示与pattern1的第一个()括号相匹配的内容，\2表示与pattern1的第二个()括号相匹配的内容。sed默认使用Basic正则表达式规范，如果指定了-r选项则使用Extended规范，那么()括号就不必转义了。


# awk
## 内置变量
$0，代表当前行  
$1,$2,...代表当前行分隔后的第n项数据  
NF 代表当前行一共被分隔为几项   
NR 代表目前所处理的是第几行，总行数
FNR：awk当前读取的记录数，其变量值小于等于NR（比如当读取第二个文件时，FNR是从0开始重新计数，而NR不会）
FS 目前的分隔符  
1. demo 1  
last -n 5|awk '{print $1 "\t lines:" NR "\t column:" NF "\t"}
2. 带条件
[liuhaozzu@centos7-1 ~]$ cat /etc/passwd |awk '{FS=":"} $3<10 {print $1 "\t" $3}'  
root:x:0:0:root:/root:/bin/bash  
bin     1  
daemon  2  
adm     3  
lp      4  
sync    5  
shutdown        6  
halt    7  
mail    8  
3. 发现上面第一行没有处理，这是因为我们处理第一行的时候，那些变量$1,$2...默认还是以空格键分隔，**虽然定义了FS，却仅能在第二行后开始生效**  
利用BEGIN关键字预先设置变量：  
 cat /etc/passwd | awk 'BEGIN {FS=":"} $3<10 {print $1 "\t" $3}'  
 [liuhaozzu@centos7-1 ~]$ cat pay.txt |awk 'NR==1 {printf "%10s,%10s,%10s,%10s,%10s\n", $1,$2,$3,$4,"Total"}\
NR>=2 {total=$2+$3+$4
printf "%10s,%10s,%10s,%10s,%10s\n", $1,$2,$3,$4,total}'
      Name,       1st,       2nd,       3th,     Total
     VBird,     23000,     24000,     25000,     72000
    DMTsai,     21000,     20000,     23000,     64000
     Bird2,     42000,     42000,     41000,    125000
     1. awk的命令间隔，在{}内的操作可以用“;”间隔，或者直接用回车来间隔
 
 

