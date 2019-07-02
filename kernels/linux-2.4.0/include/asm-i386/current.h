#ifndef _I386_CURRENT_H
#define _I386_CURRENT_H

struct task_struct;

static inline struct task_struct * get_current(void)/*源码注释：为什么不把这个地址放在一个全局变量中，使得每次调度一个新进程运行时，就将该进程的task_struct的起始地址写入这个变量，以后随便使用。实际上，一条AND指令的执行只需要4个CPU时钟周期，而一条从寄存器到寄存器的MOV指令也才2个时钟周期，所以向这样在需要时才临时把它计算出来的方式反而效率更高 */
{
	struct task_struct *current;
	__asm__("andl %%esp,%0; ":"=r" (current) : "0" (~8191UL));
	return current;
 }
 
#define current get_current()

#endif /* !(_I386_CURRENT_H) */
