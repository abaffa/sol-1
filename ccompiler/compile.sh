#! /usr/bin/bash

echo "compiling $1 ..."

./cc $1
echo "assembling a.s ..."
echo ""
wine tasm -1 -b a.s

#if [ $# -gt 1 ]; then
	xxd -ps a.obj | tr -d '\n' | xclip -selection c
	printf "\nbinary file copied to clipboard.\n"
#fi

