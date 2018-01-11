#!/usr/bin/perl

use strict;
use warnings;

##########################################################################################
#
# #################### Iker Irisarri. Jan 2018. Uppsala University ##################### #
# 
# Script to parse site rates calculated by HyPhy in PhyDesign server
#
##########################################################################################

my $usage = "perl parse_hyphy_site_rates.pl infile > STDOUT\n";
my $infile = $ARGV[0] or die $usage; 

my @site_rates = ();

open(IN, "<", $infile);

while ( my $line =<IN> ) {

	chomp $line;
	
	#print STDERR "$line\n";
	
	if ( $line =~ /^ Site .+/ ) {
	
		$line =~ s/ +/\t/g;
			
		my @lines = split ("\t", $line);
		
		# get uninformative positions
		if ( $lines[4] eq "uninformative" ) {
		
			push (@site_rates, "0");
		}
		else {
		
			push (@site_rates, $lines[10]);
		}
	}
}
close(IN);

print join (",", @site_rates), "\n";

print STDERR "\ndone!\n\n";

