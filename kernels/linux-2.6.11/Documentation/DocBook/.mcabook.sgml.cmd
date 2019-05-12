cmd_Documentation/DocBook/mcabook.sgml := SRCTREE=/home/liuhaozzu/repoes/linux/kernels/linux-2.6.11/ scripts/basic/docproc doc Documentation/DocBook/mcabook.tmpl >Documentation/DocBook/mcabook.sgml
Documentation/DocBook/mcabook.sgml: Documentation/DocBook/mcabook.tmpl arch/i386/kernel/mca.c include/asm-i386/mca_dma.h
