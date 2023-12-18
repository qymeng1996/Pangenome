#!/usr/bin/env perl -w

use strict;

my %hash;

open(IN1,"$ARGV[0]")||die "can not open the file!$!\n";
while(<IN1>){
	chomp;
	my @arr = split/\t/;
	$hash{$arr[0]} = $arr[1];
}
close IN1;

open(IN2,"$ARGV[1]")||die "can not open the file!$!\n";
while(<IN2>){
	chomp;
	my @array = split/\t/;
	print "$array[0]\t$array[1]\t$hash{$array[1]}\n";
}
close IN2;
