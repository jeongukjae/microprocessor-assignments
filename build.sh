#!/bin/bash

TEMP_DIR=tmp

mkdir $TEMP_DIR
# 임시 폴더 비우기
rm -rf $TEMP_DIR/*

# 컴파일
iverilog -o $TEMP_DIR/$1.out `ls -d -- $1/*.v`

# 결과물 실행
cd $TEMP_DIR
vvp $1.out

# open gtkwave
open -a gtkwave *.vcd
