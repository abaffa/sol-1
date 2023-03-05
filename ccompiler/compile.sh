#! /usr/bin/bash

echo
echo '**********************************************'
echo
echo "> compiling cc.c with gcc..."
gcc cc.c -o cc
echo
echo '**********************************************'
echo

echo "> compiling $1 with sol-cc..."
./cc $1

echo
echo '**********************************************'
echo

echo "> assembling a.s with TASM..."
echo

wine tasm -1 -b a.s

#if [ $# -gt 1 ]; then
	xxd -ps a.obj | tr -d '\n' | xclip -selection c
	printf "\n> binary file copied to clipboard.\n"
#fi

