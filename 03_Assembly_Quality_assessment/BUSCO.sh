#!/bin/bash

module purge;module load Singularity/3.1.1

fa_dir=/public/home/qymeng/PanGenome/Genome/Assembly/Assemble
singularity exec -e  /public/home/qymeng/PanGenome/Genome/Assembly/BUSCO/busco_v5.1.3_cv1.sif busco -i $fa_dir/$index.fa -m genome -l embryophyta_odb10 -c 20 -o $index
