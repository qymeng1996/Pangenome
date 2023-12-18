#!/usr/bin/env perl

use warnings;
use strict;

my %strand;

open COR,"$ARGV[0]" or die " can not open the file!\n";
while(<COR>){
	chomp;
	my @arr = split/\t/;
	$strand{$arr[11]}{$arr[12]}{'start'} += $arr[2];
	$strand{$arr[11]}{$arr[12]}{'end'} += $arr[3];
	}


foreach my $k1 (keys %strand){
	foreach my $k2 (keys %{$strand{$k1}}){
		if($strand{$k1}{$k2}{'start'} > $strand{$k1}{$k2}{'end'}){
			$strand{$k1}{$k2}{'strand'} = "-";
		}else{
			$strand{$k1}{$k2}{'strand'} = "+";
		}
	}
}
open F1,"$ARGV[1]" or die "can not open the file!\n";
while(<F1>){
	chomp;
	my @arr = split/\t/;
	push @arr, $strand{$arr[0]}{$arr[5]}{'strand'};
	print join "\t",@arr,"\n";
}

close COR;
close F1;
