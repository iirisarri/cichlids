#!/usr/bin/perl

# Iker Irisarri. University of Konstanz. Oct 2015

# simple script to parse csv file of pairwise genetic distances

my $infile = shift;
my $threshold = shift;

open (IN, "<", $infile) or die;

while ( my $line =<IN> ) {

	chomp $line;
	
	# scape non-informative lines
	next if ( $line =~ /^$/ || $line =~ /^Species/ || $line =~ /^Table/ || $line =~ /^The/ || $line =~ /^1._Kumar/ || $line =~ /^Disclaimer/ );
		
	my @lines = split (",", $line);
	
	if  ( $lines[2] <= $threshold && $lines[2] > 0.00001) {
	
		print "$line\n";
	}
}