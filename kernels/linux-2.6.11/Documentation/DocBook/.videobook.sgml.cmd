cmd_Documentation/DocBook/videobook.sgml := SRCTREE=/home/liuhaozzu/repoes/linux/kernels/linux-2.6.11/ scripts/basic/docproc doc Documentation/DocBook/videobook.tmpl >Documentation/DocBook/videobook.sgml
Documentation/DocBook/videobook.sgml: Documentation/DocBook/videobook.tmpl drivers/media/video/videodev.c
