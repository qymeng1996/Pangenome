#!/usr/bin/env perl

use warnings;
use strict;

my %hash;
my %hash_len;
my $name;
my $len;
my $total_len;
my $longest = 0;
my $shortest = 1000000000000;
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

my $count_A;
my $count_C;
my $count_G;
my $count_T;

foreach my $key (sort keys %hash){
	while($hash{$key} =~/a/ig){$count_A ++;}
	while($hash{$key} =~/c/ig){$count_C ++;}
	while($hash{$key} =~/g/ig){$count_G ++;}
	while($hash{$key} =~/t/ig){$count_T ++;}
	$len = length $hash{$key};
	$hash_len{$key} = $len;
	$total_len += $len;
	}

	my $average_len = $total_len/$contig;
	my $GC = ($count_G + $count_C )/$total_len;

for my $contig_len (sort{$b <=> $a} values %hash_len){
	if($longest <= $contig_len){
		$longest = $contig_len;
	}
}

for my $contig_len (sort{$b <=> $a} values %hash_len){
	if($shortest >= $contig_len){
		$shortest = $contig_len;
	}
}



print "Total length:\t$total_len\n";
print "Total contigs:\t$contig\n";
print "Average length:\t$average_len\n";
print "Longest contig:\t$longest\n";
print "Shortest contig:\t$shortest\n";
print "GC content (%):\t$GC\n";

my $N50 = 0;
my $L50 = 0;
for my $contig_len (sort{$b <=> $a} values %hash_len){
	$L50 += $contig_len;
	$N50 ++;
	if($L50 >= $total_len*0.5){
		print "Contig L50:\t$contig_len\n";
		print "Contig N50:\t$N50\n";
		last;
	}
}



close FA;
