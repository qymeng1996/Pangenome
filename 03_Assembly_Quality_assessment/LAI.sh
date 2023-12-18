#!/bin/bash

# LTR_harvest

gt suffixerator -db $index.fa -indexname $index.fa -tis -suf -lcp -des -ssp -sds -dna
gt ltrharvest -index $index.fa -minlenltr 100 -maxlenltr 7000 -mintsd 4 -maxtsd 6 -motif TGCA -motifmis 1 -similar 85 -vic 10 -seed 20 -seqids yes > $index.fa.harvest.scn


# LTR_Finder

/public/home/qymeng/biosoft/LTR_FINDER_parallel-master/LTR_FINDER_parallel  -seq $index.fa -threads 10 -harvest_out -size 1000000 -time 300

# LAI

cat $index.fa.harvest.scn $index.fa.finder.combine.scn > $index.fa.rawLTR.scn

LTR_retriever -genome $index.fa -inharvest $index.fa.rawLTR.scn -threads 10 
