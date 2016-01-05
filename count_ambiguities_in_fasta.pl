#!/usr/bin/perl

# local bioperl library for hpc2
#use lib "/home/iirisar/iirisar/lib/perl5/";
#use Bio::Perl;
 
use strict;
use Bio::SeqIO;
use Data::Dumper;

# Iker Irisarri, University of Konstanz. Dec 2015

my $usage = "count_ambiguities_in_fasta.pl infile.fa > STDOUT\n";
my $fasta = $ARGV[0] or die $usage; 


# read file in with seqio

#READ_IN: 
my $seqio_obj = Bio::SeqIO->new('-file' => "<$fasta", 
				'-format' => "fasta",
				'-alphabet' => "dna"
    );

# count number of ambiguities for the whole file

my %hash;
my @sequence;
my $ambiguities=0;
my $total_chars=0;

while (my $inseq = $seqio_obj->next_seq) {

    @sequence = split ("", $inseq->seq);
    
    foreach my $i (@sequence) {

	$total_chars++;

	if ($i !~/(A|C|G|T|a|c|t|g|-)/) { 

	    $ambiguities++;
	}
    }
}

my $proportion = $ambiguities / $total_chars;

#print "proportion of ambiguous characters (!~/(A|C|G|T|a|c|t|g|-):\n";
#print "proportion$\n";
#print STDERR "\nDone!\n";

# print infile and counts (to be run in a loop)
print "$fasta\t$proportion\n";
#print STDERR "Done!\n";                                                                                  
