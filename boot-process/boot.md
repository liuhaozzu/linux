# 启动过程
1. 加载BIOS的硬件信息与进行自我检测，并根据设置取得第一个可启动的设备
2. 读取并执行第一个启动设备内MBR的启动引导程序（即grub2，spfdisk等程序）
3. 根据启动引导程序的设置加载Kernel，Kernel会开始检测硬件，并加载驱动程序
4. 在硬件驱动成功后，Kernel会主动调用systemd程序，并以default.target流程启动：
    1. systemd执行sysinit.target 初始化系统及basic.target准备操作系统
    2. systemd执行multi-user.target下的本机与服务器服务；
    3. systemd执行multi-user.target下的/etc/rc.d/rc.local文件
    4. systemd执行multi-user.target下的getty.target及登录服务
    5. systemd执行graphical需要的服务。
## boot sector
每个文件系统都会保留一块儿启动扇区（boot sector）提供给操作系统安装boot loader，而通常操作系统默认都会安装一份loader到它根目录所在的文件系统的boot sector上。
## boot loader
1. 主要功能
        1. 提供选项：用户可以选择不同的启动选项，这也是多重引导的重要功能
        2. 加载内核文件：直接指向可启动的程序区域来启动操作系统
        3. 转交其他loader：将启动管理功能转交给其他loader负责  
        **最终，BootLoader的主要功能是【加载内核文件】**
        
## 加载内核检测硬件与initramfs的功能
[root@centos7-1 boot]# lsinitrd /boot/initramfs-3.10.0-514.el7.x86_64.img
Image: /boot/initramfs-3.10.0-514.el7.x86_64.img: 20M
========================================================================
Early CPIO image
========================================================================
drwxr-xr-x   3 root     root            0 Mar 19  2017 .
-rw-r--r--   1 root     root            2 Mar 19  2017 early_cpio
drwxr-xr-x   3 root     root            0 Mar 19  2017 kernel
drwxr-xr-x   3 root     root            0 Mar 19  2017 kernel/x86
drwxr-xr-x   2 root     root            0 Mar 19  2017 kernel/x86/microcode
-rw-r--r--   1 root     root        22528 Mar 19  2017 kernel/x86/microcode/GenuineIntel.bin
========================================================================
Version: dracut-033-463.el7

Arguments: -f

dracut modules:
bash
nss-softokn
i18n
network
ifcfg
drm
plymouth
dm
kernel-modules
lvm
resume
rootfs-block
terminfo
udev-rules
biosdevname
systemd
usrmount
base
fs-lib
shutdown
========================================================================
drwxr-xr-x  12 root     root            0 Mar 19  2017 .
crw-r--r--   1 root     root       5,   1 Mar 19  2017 dev/console
crw-r--r--   1 root     root       1,  11 Mar 19  2017 dev/kmsg
crw-r--r--   1 root     root       1,   3 Mar 19  2017 dev/null
lrwxrwxrwx   1 root     root            7 Mar 19  2017 bin -> usr/bin
drwxr-xr-x   2 root     root            0 Mar 19  2017 dev




