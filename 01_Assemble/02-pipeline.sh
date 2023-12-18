#!/bin/sh

input=$1
cor=$2
dir=$3

if [ ! -d $dir/ ];then
	mkdir $dir
fi

rm -fr $dir/*

cat $input | while read id;
do
arr=($id)
chr=${arr[0]}
ctg=${arr[1]}

cat $cor | grep $chr |grep $ctg |awk '{print $12"\t"$1"\t"$2}' > $chr.$ctg.tmp.txt
bedtools merge -d 500000 -i $chr.$ctg.tmp.txt -c 2 -o count |awk '{print $0"\t"($3-$2)}' |sort -k 5nr |head -n 1 > $chr.$ctg.t.bed
perl 02-combine_ctg.pl $cor $chr.$ctg.t.bed > $chr.t.bed
perl 02-strand.pl $cor $chr.t.bed >> $dir/$chr.t.t.bed

rm -fr $chr.$ctg.tmp.txt
rm -fr $chr.$ctg.t.bed
rm -fr $chr.t.bed
done

for i in $dir/*.bed; do
index=$(basename $i |cut -f 1 -d ".")
echo -e "#chr\tstart\tend\tcount\tscope\tctg\tchr_len\tcrg_len\tstrand" > $dir/$index.bed
cat $i |sort -k 2n >> $dir/$index.bed
done

rm -fr $dir/*.t.t.bed
