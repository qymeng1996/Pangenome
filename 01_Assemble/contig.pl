#!/usr/bin/env perl

use warnings;
use strict;

my %hash;
my $name;
my $i = 1;

if($ARGV[0] =~ m/\.gz/){
    open FA, "gzip -dc $ARGV[0] |" || die "can not open the file!\n";
}else{
    open FA,"$ARGV[0]" || die "can not open the file!\n";
}
open ID,"$ARGV[1]" || die "can not open the file!\n";

while(<FA>){
	chomp;
	if (/>(.+)/){
	$name = $1;
	}else{
	tr/atcgnx/ATCGNX/;
	$hash{$name} .= $_;
	}
}

while(<ID>){
	chomp;
	my @arr = split /\t/;
	my $ctg = $arr[0];
	if(exists $hash{$ctg}){
		print ">Contig";
		printf "%04d",$i;
		print "\n";
		print "$hash{$ctg}\n";
		$i += 1;
	}
}

close FA;
close ID;
