#!/usr/bin/perl

# local bioperl library for hpc2
#use lib "/home/iirisar/iirisar/lib/perl5/";
#use Bio::Perl;
 
use strict;
use Bio::SeqIO;
use Data::Dumper;

# Iker Irisarri, University of Konstanz. Feb 2015
# modified from rm_petromyzon_from_fasta.pl

my $usage = "remove_ophthalmotilapia.pl infile.fa > STDOUT\n";
my $fasta = $ARGV[0] or die $usage; 


# read file in with seqio

#READ_IN: 
my $seqio_obj = Bio::SeqIO->new('-file' => "<$fasta", 
				'-format' => "fasta", 
				'-alphabet' => "protein"
				);

# store sequences in a hash

my %hash;

while (my $inseq = $seqio_obj->next_seq) {

    if ( $inseq->primary_id !~ /^I9170_1_81_Ophthalmotilapia_ventralis_seq1/g ) {

	print ">", $inseq->primary_id, "\n";
	print $inseq->seq, "\n";
    }
    else {

	print STDERR "I9170_1_81_Ophthalmotilapia_ventralis_seq1 removed!\n";

    }

}
   
