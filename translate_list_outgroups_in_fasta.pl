#!/usr/bin/perl
 
use strict;
use Bio::SeqIO;
use Data::Dumper;

# Iker Irisarri, Jan 2016. University of Konstanz
# modified from reduce_outgroups_from_fasta.pl
# Script identify one outgroup from each fasta file => gene trees for MP-EST
# MP-EST requires single outgroup but this does not need to be the same for all genes
# Outgroups are selected according to an input list of ordered taxa
# Files need to contain at least one taxa of this list (or put them all in the list) to print stuff out!
# Compared to reduce_outgroups_from_fasta.pl, this script does not remove any outgroup


my $usage = "translate_list_outgroups_in_fasta.pl infile.fa outgroups.list > outfile.fa 2> summary\n ";
my $fasta = $ARGV[0] or die $usage; 
my $list = $ARGV[1] or die $usage;
my $summary = "translate_list_outgroups_in_fasta.summary";

# read file in with seqio

#READ_IN: 
my $seqio_obj = Bio::SeqIO->new('-file' => "<$fasta", 
				'-format' => "fasta", 
			#	'-alphabet' => "protein"
				'-alphabet' => "dna"
				);

# store sequences in a hash

my %hash;

while (my $inseq = $seqio_obj->next_seq) {
#	my $name = $inseq->primary_id;
	# reduce number of characters to 10
	# to remove gene name from Lepidosiren and Neoceratodus that I added for the BLAST step	
	#$inseq->primary_id=~/(.{10}).*/g;
	my $header = $inseq->primary_id;
	my $seq = $inseq->seq;
	# hash where $seqname are keys and take the value sof $seq
	$hash{$header}=[$seq];
}

print STDERR "FILE: $fasta\n";

my @outgroups;

# read-in and save list of outgroups (ordered)
open (IN, "<", $list);

while ( my $line =<IN> ) {
    chomp $line;
    push ( @outgroups, $line);
}

my $orig_seqcount=0;
my $print_seqcount = 0;

# find outgroup according to list order, translate and print
foreach my $outg (@outgroups) {

    if (exists $hash{$outg}) {
        foreach my $name (sort keys %hash) {
	    $orig_seqcount = scalar keys %hash;
	    # tranaslate outgroup header to "outgroup"
	    if ( $name eq "$outg" ) {
		print STDERR "\t$name found! Header replaced by >outgroup\n";
		print ">outgroup\n";
		print $hash{$name}[0], "\n";
		$print_seqcount++;
	    }
	    # print all sequences in %hash
	    else {
		print ">", $name, "\n";
		print $hash{$name}[0], "\n";
		$print_seqcount++;
	    }
	}
	# check No. Seqs before and after
	print STDERR "\tNo. Seq Before: $orig_seqcount After: $print_seqcount\n";
	# scape loop if $outg is found
	last;
    }
}

__END__

