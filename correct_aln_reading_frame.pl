#!/usr/bin/perl

# local bioperl library for hpc2
#use lib "/home/iirisar/iirisar/lib/perl5/";
#use Bio::Perl;
 
use strict;
use Bio::SeqIO;
use Bio::Align::Utilities qw(:all);
use Data::Dumper;

# Iker Irisarri, University of Konstanz. Sep 2016
# script reads fasta MSA and checks whether it is in the correct reading frame and prints a notice
# if not, it tries to find the correct reading frame and prints out a corrected file
# if the file contains any * after trying all 3 reading frames, a WARN is printed
# ideas for improvements:
#	- remove final stop codons
#	- modify pattern matching to count all stop codons (currently only one per sequence)

my $usage = "correct_aln_reading_frame.pl infile.fa > STDOUT (info)\n";
my $fasta = $ARGV[0] or die $usage; 


# read file in with seqio

my $seqio_obj = Bio::SeqIO->new('-file' => "<$fasta", 
								'-format' => "fasta",
								'-alphabet' => "dna"
    );


my %original;
my %translated;
my $stop_counter = 0;

# read-in sequences and store
while (my $inseq = $seqio_obj->next_seq) {

	# remove sequenced with only gaps or undetermined sequences
	next if ( $inseq->seq =~ /^[-XNn?]*$/ );

	# save seq objects
	$original{$inseq->primary_id} = $inseq;
}

# loop for each reading frame
foreach my $rf (0, 1, 2) {

	# reinitialize for each reading frame
	$stop_counter = 0;

	# translate, save and count stop codons
	foreach my $key ( keys %original ) {

		my $prot_obj = $original{$key}->translate(-codontable_id => 1,
													-frame => $rf);
										
		$translated{$key} = $prot_obj->seq;

		# count stop codons in each sequence
		# this will count one * per sequence (could not modify to count multiple times)
		if ( $prot_obj->seq =~ /\*/g ) {
	
			$stop_counter++;
		}

	}
	
	if ( $rf == 0 && $stop_counter == 0 ) {
	
		print "Reading frame 0 correct for $fasta\n";
		last;
	}
	if ( $rf == 1 && $stop_counter == 0 ) {
	
		print "Reading frame +1 correct for $fasta\n";
		print "\tNew file: $fasta.+1.fa\n";
		
		# create new file after adding one gap to all seqs
		open (OUT, ">", "$fasta.+1.fa");
		foreach my $k ( keys %original ) {

			print OUT ">$k\n";		
			my $seq1 = $original{$k}->seq;
			print OUT "--". "$seq1\n";		
		}	
		last;
		close(OUT);
	}
	if ( $rf == 2 && $stop_counter == 0 ) {
	
		print "Reading frame +2 correct for $fasta\n";
		print "\tNew file: $fasta.+2.fa\n";
		
		# create new file after adding one gap to all seqs
		open (OUT, ">", "$fasta.+2.fa");
		foreach my $k ( keys %original ) {
		
			print OUT ">$k\n";
			my $seq2 = $original{$k}->seq;
			print OUT "-". "$seq2\n";		
		}		
		last;
		close(OUT);
	}
}

if ( $stop_counter > 0 ) {
	
	print "WARN: stop codons present, nothing done for $fasta\n";
}

print "\ndone!\n\n";

#print Dumper \%translated;
#print "$stop_counter\n";

