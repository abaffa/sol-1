#! /bin/bash


wine tasm -1 -b kernel.s obj/kernel.obj
wine tasm -1 -b shell.s lst/kernel.lst

for FILE in *.s; do
	f=$(echo $FILE | sed 's/.s//g')
	printf "\n$FILE\n"
	wine tasm -1 -b $FILE obj/$f.obj lst/$f.lst
done


printf "\n$1\n"
wine tasm -1 -b $1.s obj/$1.obj lst/$1.lst

xxd -ps obj/$1.obj | tr -d '\n' | xclip -selection c
printf "\n> binary file copied to clipboard.\n"
