#! /bin/bash


wine tasm -1 -b kernel.s
wine tasm -1 -b shell.s

for FILE in *.s; do
	printf "\n$FILE\n"
	wine tasm -1 -b $FILE
done

