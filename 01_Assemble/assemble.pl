#!/usr/bin/env perl

use warnings;
use strict;
use File::Basename;

my %genome;
my $chr_name;
my %hash;
my $gap = "N" x 1000;
my @array;

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

open TAB,"$ARGV[1]" or die " can not open the file!\n";
while(<TAB>){
	chomp;
	next if /^#/;
	my @arr = split/\t/;
	$hash{$arr[5]}{'strand'} = $arr[8];
	push @array,$arr[5];

}

my $fullname = $ARGV[1];
my @suffixlist = qw (.bed .pos);
my ($name, $path, $suffix) = fileparse($fullname, @suffixlist);


print ">$name\n";
foreach my $chr ( @array){
		if( $hash{$chr}{'strand'} eq "+"){
			$hash{$chr}{'seq'} = $genome{$chr};
		}else{
			$hash{$chr}{'seq'} = rev( $genome{$chr} );
		}
}

	
	my $count = scalar @array;
	if( $count > 1){
		for(my $i = 0; $i < $count-1; $i++){
			my $seq = $hash{$array[$i]}{'seq'};
			print "$seq";
			print "$gap";
		}
			my $seq = $hash{$array[$count-1]}{'seq'};
			print "$seq\n";
	}else{	
			my $seq = $hash{$array[0]}{'seq'};
			print "$seq\n";
		}

sub rev{
	my $temp = shift @_;
	$temp =~ tr/atcgATCG/tagcTAGC/;
	return reverse($temp);
}





close FA;
close TAB;
