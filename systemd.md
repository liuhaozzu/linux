# systemd,systemctl
1. Centos7中systemd替代/etc/init.d/daemon
2. systemd优势
    1. 并行处理所有服务，加速开机流程
    2. 常驻内存，响应迅速
    3. 服务依赖自我检查
    4. 按照daemon功能分类
    5. 将多个daemons集合成一个群组
## 通过systemctl管理服务
### service
对于service类型 用start，stop等参数
1. systemctl status/start/disable/enable/mask/unmask servicename
    1. mask #注销服务，只是让启动的脚本变成空的设备
    2. unmask #恢复
2. systemctl # 列出系统上面所有启动的服务

### target
对于target 使用isolate（隔离不同的操作模式的意思）
1. systemctl list-units --type=target --all # 列出所有操作环境
2. systemctl isolate multi-user.target #切换工作环境到命令行模式

### 模式切换快捷命令
systemctl poweroff
systemctl suspend/reboot/hibernate/rescue/emergency

## 分析服务间的依赖
1. systemctl list-dependencies [unit] [--reverse]

## 列出socket文件
[root@centos7-1 system]# systemctl list-sockets
LISTEN                      UNIT                         ACTIVATES
/dev/log                    systemd-journald.socket      systemd-journald.service
/run/dbus/system_bus_socket dbus.socket                  dbus.service
