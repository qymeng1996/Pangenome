#!/bin/bash

sample=$1

index=$(basename $sample)
perl /public/home/qymeng/PanGenome/Genome/Assembly/NGx/Script/Genome_basic_statisitcs.pl ${sample} 

cat ${sample} |sed 's/^>.*/N/'|awk 'BEGIN{RS="N";OFS="\n";i=1}{if(length($0)>1){print ">seq_"i,$0; i++}}' >split-${index}.fa

perl Script/N10.pl split-${index}.fa 
perl Script/N20.pl split-${index}.fa 
perl Script/N30.pl split-${index}.fa 
perl Script/N40.pl split-${index}.fa 
perl Script/N50.pl split-${index}.fa 
perl Script/N60.pl split-${index}.fa 
perl Script/N70.pl split-${index}.fa 
perl Script/N80.pl split-${index}.fa 
perl Script/N90.pl split-${index}.fa 


rm -fr  split-${index}.fa

