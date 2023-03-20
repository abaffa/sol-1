CC = gcc
CFLAGS = -Wall

.PHONY: compile_file

compile_file: cc
ifeq ($(FILE),)
	@echo "Error: Please provide a file to compile using FILE=<filename>"
	@exit 1
else
	./cc $(FILE)
	wine tasm -1 -b a.s
	xxd -ps a.obj | tr -d '\n' | xclip -selection c
	echo "> .obj copied to clipboard in intel-hex format"
endif

cc: cc.o 
	$(CC) $(CFLAGS) -o cc cc.o
	rm cc.o

cc.o: cc.c def.h
	$(CC) $(CFLAGS) -c cc.c

clean:
	rm -f cc cc.o