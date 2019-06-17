all: main
main: main.o stack.o maze.o 
	gcc $^ -o $@
#main.o: main.c main.h stack.h maze.h
#stack.o: stack.c stack.h main.h
#maze.o: maze.c maze.h main.h
clean:
	@echo "cleaning project"
	-rm main *.o
	@echo "clean completed"
.PHONY: clean

sources = main.c stack.c maze.c

include $(sources:.c=.d)

%.d: %.c
	set -e; rm -rf $@; \
	$(CC) -MM $(CPPFLAGS) $< > $@.$$$$; \
	sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' < $@.$$$$ > $@; \
	rm -f $@.$$$$

