#!/usr/bin/env perl

use warnings;
use strict;

my %hash;
my %hash_len;
my $name;
my $len;
my $total_len;
my $longest = 0;
my $contig = 0;

if($ARGV[0] =~ m/\.gz/){
    open FA, "gzip -dc $ARGV[0] |" || die "can not open the file!\n";
}else{
    open FA,"$ARGV[0]" || die "can not open the file!\n";
}

while(<FA>){
	chomp;
	if (/>(.+)/){
	$contig ++;
	$name = $1;
	}else{
	tr/atcgnx/ATCGNX/;
	$hash{$name} .= $_;
	}
	
}
close FA;

print "\n";
foreach my $key (sort keys %hash){
#	while($hash{$key} =~/a/ig){$count_A ++;}
#	while($hash{$key} =~/c/ig){$count_C ++;}
#	while($hash{$key} =~/g/ig){$count_G ++;}
#	while($hash{$key} =~/t/ig){$count_T ++;}
#	while($hash{$key} =~/n/ig){$count_N ++;}
	$len = length $hash{$key};
	$hash_len{$key} = $len;
	$total_len += $len;
	}

for my $contig_len (sort{$b <=> $a} values %hash_len){
	if($longest <= $contig_len){
		$longest = $contig_len;
	}
}

#print "Total length:\t$total_len\n";
print "Total contig:\t$contig\n";
#print "Gaps length:\t$count_N\n";
print "Longest length:\t$longest\n";
#print "GC content (%):\t$GC\n";



my $N10 = 0;
my $L10 = 0;
for my $contig_len (sort{$b <=> $a} values %hash_len){
	$L10 += $contig_len;
	$N10 ++;
	if($L10 >= $total_len*0.1){
		print "Contig L10:\t$contig_len\n";
		print "Contig N10:\t$N10\n";
		last;
	}
}