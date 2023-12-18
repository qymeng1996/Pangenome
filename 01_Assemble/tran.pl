#!/usr/bin/env perl

use warnings;
use strict;

my %genome;
my $chr_name;

if($ARGV[0] =~ m/\.gz/){
	open FA, "gzip -dc $ARGV[0] |" || die "can not open the file!\n";
}else{
	open FA,"$ARGV[0]" || die "can not open the file!\n";
}

while(<FA>){
	chomp;
	if (/>(.+)/){
		$chr_name = $1;
	}else{
		tr/atcgnx/ATCGNX/;
		$genome{$chr_name} .= $_;
	}						
}


foreach my $key (sort keys %genome){
	print ">$key\n";
	my $seq = tran( $genome{$key});
	print "$seq\n";
}

sub tran{
	my $temp = shift @_;
	$temp =~ tr/atcgnNATCG/tagcnNTAGC/;
	return $temp;
}





close FA;
