#!/usr/bin/perl -w

use strict;

use Bio::DB::Fasta;
use Bio::SeqIO;
use Data::Dumper;

my $usage = "tirm_fasta_header_phased_alns.pl infile > STDOUT\n";
my $fasta = $ARGV[0] or die $usage;

# read fasta file with SeqIO
my $seqio_obj = Bio::SeqIO->new('-file' => "<$fasta",
								'-format' => "fasta");
                		        
while (my $seq_obj = $seqio_obj->next_seq){

    my $seqname = $seq_obj->primary_id;
    
    my @seqname_bits = split ("_", $seqname);
    my $first_bit = $seqname_bits[0];
    my $last_bit = $seqname_bits[$#seqname_bits];

    my $seqname_reduced = "";
    
    # modify headers of phased alleles
    if ( $last_bit eq "seq1" || $last_bit eq "seq2" ) {
    
    	# modify headers with format I9098_1_9_Neolamprologus_christyi_seq2 
    	if ( $first_bit =~ /I9\d+/ ) {
    		
    		$seqname_reduced = $seqname_bits[0]  . "_" . $seqname_bits[1] . "_" . $seqname_bits[2] . "_" . $seqname_bits[$#seqname_bits];
    	}
     	# modify headers with format I11181_14624_Tilapia__sparrmanii_seq1 
    	if ( $first_bit =~ /I1\d+/ ) {
    	
    		$seqname_reduced = $seqname_bits[0]  . "_" . $seqname_bits[1] . "_" . $seqname_bits[$#seqname_bits];
    	}
    	print ">$seqname_reduced\n";
    	print $seq_obj->seq, "\n";
    }
    # print out headers of genomes
    else {
        print ">",  $seq_obj->primary_id, "\n";
       	print $seq_obj->seq, "\n";
    }
}

print STDERR "\ndone!\n\n";
