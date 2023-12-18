#!/usr/bin/env perl -w

use strict;

my %hash;

open(IN1,"$ARGV[0]")||die "can not open the file!$!\n";
while(<IN1>){
	chomp;
	my @arr = split/\t/;
	$hash{$arr[11]}{$arr[0]}{'ctg'} = $arr[12];
	$hash{$arr[11]}{$arr[0]}{'chr_len'} = $arr[7];
	$hash{$arr[11]}{$arr[0]}{'ctg_len'} = $arr[8];
}
close IN1;

open(IN2,"$ARGV[1]")||die "can not open the file!$!\n";
while(<IN2>){
	chomp;
	my @array = split/\t/;
	push @array,$hash{$array[0]}{$array[1]}{'ctg'};
	push @array,$hash{$array[0]}{$array[1]}{'chr_len'};
	push @array,$hash{$array[0]}{$array[1]}{'ctg_len'};
	print join "\t",@array,"\n";
}
close IN2;
