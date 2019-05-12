cmd_Documentation/DocBook/deviceiobook.sgml := SRCTREE=/home/liuhaozzu/repoes/linux/kernels/linux-2.6.11/ scripts/basic/docproc doc Documentation/DocBook/deviceiobook.tmpl >Documentation/DocBook/deviceiobook.sgml
Documentation/DocBook/deviceiobook.sgml: Documentation/DocBook/deviceiobook.tmpl include/asm-i386/io.h
