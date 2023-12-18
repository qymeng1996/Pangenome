#!/bin/sh

input=$1
prefix=$(basename $input |cut -f 1 -d '.')

cat $input | cut -f 2 |sort |uniq > $prefix.ctg.txt
cat $input | awk '$5 >0.2{print $0}' >$prefix.filter.txt
for i in `less $prefix.ctg.txt`; do cat $prefix.filter.txt |grep $i |sort -k 5nr ;done > $prefix.align.txt
# Manual check 

