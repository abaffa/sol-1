#! /usr/bin/bash

echo "> compiling cc.c with gcc..."
gcc cc.c -o cc

echo "> compiling $1 with sol-cc..."
./cc $1

echo "> assembling a.s with TASM..."
echo ""

wine tasm -1 -b a.s

#if [ $# -gt 1 ]; then
	xxd -ps a.obj | tr -d '\n' | xclip -selection c
	printf "\n> binary file copied to clipboard.\n"
#fi

