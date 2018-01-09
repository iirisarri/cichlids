#!/usr/bin/perl

 
use strict;
use Bio::SeqIO;
use Data::Dumper;

# Iker Irisarri, Uppsala University. Jan 2018

my $usage = "randomly_select_allele_from_fasta.pl infile.fa > STDOUT\n";
my $fasta = $ARGV[0] or die $usage; 


# read file in with seqio

#READ_IN: 
my $seqio_obj = Bio::SeqIO->new('-file' => "<$fasta", 
				'-format' => "fasta", 
				'-alphabet' => "dna"
				);

# store sequences in a hash

my %hash;
my @random = qw (seq1 seq2);

while (my $inseq = $seqio_obj->next_seq) {

	# genomes do not end in "_seq1" or "_seq2", so save them directly
	if ( $inseq->primary_id =~ /(.+?)_(LOC)/) {
	
		$hash{$inseq->primary_id} = $inseq->seq;
	    print STDERR "Taxa: ", $inseq->primary_id, " saved\n";
		next;
	}
	
	# trim allele info
    $inseq->primary_id =~ /(.+?)_(seq\d)/;
    
    my $taxa = $1;
    my $allele = $2;
        
    # save info first time taxa appears
    if ( !exists $hash{$taxa} ) {

	    $hash{$taxa} = $inseq->seq;
	    print STDERR "Taxa: $taxa\n";
	    print STDERR "\tsaved seq1\n";
	}
	# for second appearance of taxa, decide which allel to keep
	else {
	
		# randomly choose seq1 or seq2
		my $n = $random[rand @random];

		# replace sequence if chosen allele is not seq1
		# otherwise, skip this sequence
		if ( $n eq "seq2" ) {
	
			$hash{$taxa} = $inseq->seq;
			
			print STDERR "\treplaced by $n\n";
		}
	}
}


# print out results
foreach my $key ( sort keys %hash ) {

	print ">$key\n";
	print "$hash{$key}\n";
}	
