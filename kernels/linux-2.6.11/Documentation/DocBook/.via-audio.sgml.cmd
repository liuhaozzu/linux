cmd_Documentation/DocBook/via-audio.sgml := SRCTREE=/home/liuhaozzu/repoes/linux/kernels/linux-2.6.11/ scripts/basic/docproc doc Documentation/DocBook/via-audio.tmpl >Documentation/DocBook/via-audio.sgml
Documentation/DocBook/via-audio.sgml: Documentation/DocBook/via-audio.tmpl sound/oss/via82cxxx_audio.c
