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

### linux将内核解压缩到内存中
利用内核的功能开始测试与驱动各个周边设备，包括存储设备，cpu，网卡，声卡  
此时，linux内核会 以自己的功能重新检测一次硬件，而不一定会用BIOS检测到的硬件信息。也就是说，内核此时，才开始接管BIOS的工作。

### linux内核可以动态加载内核模块
这些模块一般位于/lib/modules/目录下面。由于模块放置在磁盘根目录内，（/lib和/ 不可以在不同的磁盘分区），因此在启动的过程中内核必须是要挂载根目录的。这样才能读取内核模块提供的加载驱动程序功能。并且由于担心影响到磁盘内的文件系统，因此启动过程中根目录是以只读的方式挂载的。

## 问题？
1. 内核不能识别SATA硬盘，需要加载SATA磁盘的驱动程序，否则无法挂载根目录
2. 但是SATA的驱动程序在/lib/modules内，你根本无法挂载根目录，又怎么能读取到该目录下的文件呢？

## 虚拟文件系统 initial RAM Disk或Initial RAM Filesystem
1. 一般文件名为 /boot/initrd或/boot/initramfs 
2. 该文件的特点：他也能够通过boot loader来加载到内存中，
3. 然后这个文件会被解压缩并且在内存中模拟成一个根目录。
4. 此模拟在内存当中的文件系统能够提供一个可执行的程序
5. 通过该程序来加载启动过程中所最需要的内核模块，通常这些模块就是USB，RAID，LVM，SCSI等文件系统与磁盘接口的驱动程序
6. 加载完成后，会帮助内核重新调用systemd来开始后续的正常启动流程。

### initramfs文件中的内容
[root@centos7-1 boot]# lsinitrd /boot/initramfs-3.10.0-514.el7.x86_64.img  
包含量大区块  
1. 事先声明的一些数据
2. 虚拟文件系统



 
