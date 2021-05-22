# CFS调度器
1. 不需要时间片概念
2. 只考虑进程的等待时间，即进程在就绪队列中已经等待了多久。

## 进程优先级
1. task_struct采用了3个 成员来表示进程的优先级：prio，normal_prio 表示动态优先级，static_prio表示进程的静态优先级。
    1. 静态优先级是进程启动时分配的，可以通过nice 和 sched_setscheduler系统调用修改，否则在进程运行期间会一直保持恒定。
    2. normal_prio:基于静态优先级和调度策略计算出的优先级。进程分支时，子进程会继承普通优先级。
    3. prio：调度器直接使用的优先级。由于在有些情况下内核需要暂时提高进程的优先级，因此需要第三个成员来表示。

## 核心调度器
### 周期性调度器
1. scheduler_tick  主要执行以下两个任务：
    1. 管理内核中与整个系统和各个进程的调度相关的统计量。其间执行的主要操作是对各种计数器加一
    2. 激活负责当前进程的调度类的周期性调度方法。  
        如果当前进程应该被重新调度，那么调度器类方法会在task_struct中设置TIF_NEED_RESCHED标志。
2. 主调度器：主调度器函数 schedule  
    1. 在从系统调用返回之后，内核也会检查当前进程是否设置了重调度标志。
    2. __sched前缀，用于可能调用schedule的函数，包括schedule自身；其主要目的：将相关函数的代码编译后 ，放到目标文件的一个特定的段中，即 .sched.text。该信息使得内核在显示栈转储或类似信息时，忽略所有与调度有关的调用。
    ```
    if (likely(prev != next)) {
		rq->nr_switches++;
		rq->curr = next;
		++*switch_count;

		context_switch(rq, prev, next); /* unlocks the rq */
	} else
		spin_unlock_irq(&rq->lock);

	if (unlikely(reacquire_kernel_lock(current) < 0)) {
		cpu = smp_processor_id();
		rq = cpu_rq(cpu);
		goto need_resched_nonpreemptible;
	}
	preempt_enable_no_resched();
	if (unlikely(test_thread_flag(TIF_NEED_RESCHED)))
		goto need_resched;
    ```
    上述代码片段可能在两个不同的上下文中执行。在没有执行上下文切换时，它在schedule函数的末尾直接执行。但如果已经执行了上下文切换，当前进程会正好在这以前停止运行，新进程已经接管了cpu。但稍后在前一进程被再次选择运行时，它会刚好在这一点上恢复运行。在这种情况下，由于prev不会指向正确的进程，所以需要通过current和test_thread_flag找到当前线程。  
3. switch_to的复杂之处: 通过3个参数传递两个变量！！！这是因为上下文切换不是涉及两个进程，而是3个进程

4. CFS 操作  
    1. 虚拟时钟  
        用于度量等待进程在完全公平系统中所能获得的cpu时间。
5. 红黑树的排序：se->vruntime - cfs_rq->min_vruntime 
    1. 在进程运行时，其vruntime稳定的增加，它在红黑树中总是向右移动。越重要的进程vruntime增加的越缓慢，因此他们向右移动的速度也越慢。
    2. 如果进程进入睡眠，其vruntime保持不变。因为每个队列min_vruntime同时会增加，那么睡眠进程醒来后，在红黑树中的位置会更靠左。因为其键值变得更小了。