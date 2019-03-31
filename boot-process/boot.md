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
