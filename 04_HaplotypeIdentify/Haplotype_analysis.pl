#!/usr/bin/env perl

use warnings;
use strict;

my %hash;
my @acc;
my $col;
my @accession;


if($ARGV[0] =~ m/\.gz/){
	open F, "gzip -dc $ARGV[0] |" || die "can not open the file!\n";
}else{
	open(F,"$ARGV[0]")||die "can not open the file!\n";
}

while(<F>){
	chomp;
	next if /^##/;
	if( /^#C/ ){
		my @Column = split /\t/;
		$col = @Column;
		for(my $j = 9; $j <= $col-1; $j++){
			$acc[$j] = $Column[$j];
			push @accession, $acc[$j]; 
		}
	}
	unless( /^#/ ){
		my @arr = split /\t/;
		my $chr = $arr[0];
		my $pos = int($arr[1]/10000)+1;
		$hash{$chr}{$pos}{'count'}++;
		for(my $i = 9; $i <= $col-1; $i++ ){
			my $GT = (split /:/,$arr[$i])[0];
			next if( $GT eq "./.");
			if( $GT eq "0/0"){
				$hash{$chr}{$pos}{$acc[$i]}{'Ref'} += 1;
			}
			elsif( $GT eq "0/1" ){
				$hash{$chr}{$pos}{$acc[$i]}{'Ref'} += 0.5;
				$hash{$chr}{$pos}{$acc[$i]}{'Alt'} += 0.5;
			}		
			else{
				$hash{$chr}{$pos}{$acc[$i]}{'Alt'} += 1;
			}
		}
	}
}


print "CHR\tPOS\t";
print join("\t",@accession),"\n";
foreach my $chr (sort keys %hash){
	foreach my $pos(sort {$a<=>$b}keys %{$hash{$chr}}){
		print "$chr\t$pos\t";
		foreach my $accs (@accession){ 
			if(!exists $hash{$chr}{$pos}{$accs}{'Ref'}){
				$hash{$chr}{$pos}{$accs}{'Ref'} = 0;
			}
			my $per = $hash{$chr}{$pos}{$accs}{'Ref'}/$hash{$chr}{$pos}{'count'};
			if( $per > 0.75 ){
				print "1\t";
			}
			elsif( $per < 0.25 ){
				print "0\t";
			}
			else{
				print "0.5\t";
			}
		}
		print "\n";
	}
}

close F;
