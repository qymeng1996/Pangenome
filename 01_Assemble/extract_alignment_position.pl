#!/usr/bin/env perl

use warnings;
use strict;

my %map;

open COR,"$ARGV[0]" or die " can not open the file!\n";
while(<COR>){
	chomp;
	my @arr = split /\t/;
	my $chr = $arr[11];
	my $ctg = $arr[12];
	my $start = $arr[2];
	my $end = $arr[3];
	my $ctg_len = $arr[8];
	my $ali_len = $arr[5];
	$map{$chr}{$ctg}{'len'} = $ctg_len;
	$map{$chr}{$ctg}{'ali'} += $ali_len;
}

foreach my $k1 (sort keys %map){
	foreach my $k2 (keys %{$map{$k1}}){
		my $map_ratio = $map{$k1}{$k2}{'ali'}/$map{$k1}{$k2}{'len'};
		print "$k1\t$k2\t$map{$k1}{$k2}{'len'}\t$map{$k1}{$k2}{'ali'}\t$map_ratio\n";
	}
}

close COR;
