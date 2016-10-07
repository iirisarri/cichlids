#!/usr/perl

use strict;
use warnings;

use Data::Dumper;

# Iker Irisarri. University of Konstanz, October 2016
# Script reads in a number of nexus files in a directory and prints out no. common taxa
# Originally to check this information from incomplete gene alignments 
# prior to run PhyloNetworks pipeline

my $usage = "check_taxa_overlap_nexus_files.pl directory/ > STDOUT\n";
my $dir = $ARGV[0] or die $usage;

# remove "/" if given in the directory name (to avoid having "//" in glob line 21
if ( $dir =~/([a-zA-Z\d\-_]+)\// ) {

	$dir = $1;
}

# read-in files
my @infiles_path = glob ( "$dir/*.nex" ); 

my %files_taxa;
my $infile_count = 0;

# loop through files to store taxa infiles
foreach my $infile_path ( @infiles_path ) {

	open (IN, "<", $infile_path) or die "Can't open file $infile_path\n";
	my @taxa = ();
	
	my $infile = (split ("/", $infile_path))[1];
	
	while ( my $line = <IN> ) {	

		chomp $line;
		# skip empty lines and everything before (and including) matrix
		next if $line =~ /^\s*$/ || $line =~ /^#Nexus/i || $line =~ /^Begin.*/i || 
				$line =~ /^dimensions/i || $line =~ /^format.*/i || $line =~ /^matrix$/i;
		
		# get taxon names
		if ( $line =~ /([a-zA-Z\d\-_]+)\s+.*/ ) {
		
			my $taxon = $1;		
		
			push (@taxa, $taxon);
		}		
		# skip everything after end;
		last if $line =~ /^end;$/i;
	}

	# sort array
	my @taxa_sorted = sort @taxa;
	
	# security check that gene is not existing
	if ( exists $files_taxa{$infile} ) { die "ERR: Duplicated infile: $infile!\n"; }
	
	# store in %hash
	$files_taxa{$infile} = [@taxa_sorted];
 	close(IN);
 	$infile_count++;
}

#print Dumper \%files_taxa;

# summarize number of taxa overall
my %common_taxa;

foreach my $key ( keys %files_taxa ) {

	foreach my $t ( @{$files_taxa{$key} } ) {

		if ( !exists $common_taxa{$t} ) {
	
			$common_taxa{$t} = 1;
		}
		else {
	
			$common_taxa{$t}++;
		}
	}
}

# print out common taxa
print "\nCOMMON TAXA\n";
print "Total number of genes: $infile_count\n";
print "Taxa common to all genes:\n";

my $common_count = 0;

foreach my $k ( keys %common_taxa ) {

	if ( $common_taxa{$k} == $infile_count ) {
	
		print "\t$k\n";
		$common_count++;
	}
}

print "Total number of common taxa: $common_count\n\n";

# print out num. times each taxa is present
print "\nTAXA COUNT\n";
print "Total number of genes: $infile_count\n";
print "\tTaxon\tCount\n";

foreach my $k ( keys %common_taxa ) {

	print "\t$k:\t$common_taxa{$k}\n";
}

print STDERR "\ndone!\n\n";





