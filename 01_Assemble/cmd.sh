# 01 Denovo assembly

input=$1
ref=/public/home/cotton/public_data/cotton_genome/3-79_HAU_v2/Gbarbadense_3-79_HAU_v2.Chr.fa

hifiasm -t 30 $input.fq.gz -o $input

awk '/^S/{print ">"$2;print $3}' $input.bp.p_ctg.gfa > $input.ctg.fa
samtools faidx $input.ctg.fa 
cat $input.ctg.fa.fai | sort -k 2nr | cut -f 1,2 > $input.length

# 02 Align to reference genome

nucmer4 -t 20 -c 1000 -l 100 $ref $input.ctg.fa -p $input
delta-filter -i 90 -l 10000 -1 $input.delta > $input.delta.filter
show-coords -crl -TH $input.delta.filter > $input.delta.filter.cor


# 03 Anchor and Order

perl extract_alignment_position.pl  $input.delta.filter.cor > alignment
sh 01-pipeline.sh alignment
# Manual check alignment result
sh 02-pipeline.sh $input.align.txt $input.delta.filter.cor bed

cat bed/*bed | grep -v "^#chr" | cut -f 6 >$input.chr 
cat $input.length | grep -v -f $input.chr  | cut -f 1 > $input.contig


for i in bed/*.bed;
do 
index=$(basename $i | cut -f 1 -d ".")
perl assemble.pl $input.ctg.fa $i >$index.fas
done

perl contig.pl $input.ctg.fa  $input.contig > Contig.fas


cat *fas > $input.assembly.fa



