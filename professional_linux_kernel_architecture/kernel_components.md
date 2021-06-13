# 地址空间与特权级别
1. 系统中每个用户进程都有自身的虚拟地址范围，从0到TASK_SIZE。用户空间之上的区域（从TASK_SIZE到2^32或2^64）保留给内核专用。
2. 特权级别：  
    1. Linux只支持两种不同的状态：内核态和用户态
    2. 用户态禁止访问内核空间
    3. 除了通过系统调用让内核代表用户程序执行代码之外，内核还可以由异步硬件中断激活，然后在中断上下文中运行。但是中断上下文中运行不能访问虚拟地址空间中的用户空间部分。因为中断可能随机发生，中断发生时可能是任一用户进程处于活动状态，由于该进程基本上与中断的原因无关，因此内核无权访问当前进程用户空间。