#!/usr/bin/perl

#Script written by Dr Patrick O'Connor patrick_kiwi@hotmail.com
#Auckland Cancer Socitry Research Centre (New Zealand)
#Prints the difference in any particular property ie HF, ZPE
#between states with pattern matched filenames ie. 412_singlet.log and 412_doublet.log
#Feel free to use as you wish.

my %data; 	#Global variable, the HoA data container

#loads energies etc into data container
my $scale_factor = 1;  #ZPVE scale factor
my @files = glob("*.log");
foreach (@files) {
&load_data();  	
}

#Pull apart the filename wiht REGEX's and
#print the data on a single line 

my $counter = 0;
my $doublet; #filename of state A
my $singlet; #filename of state B

for my $filename (sort keys %data){
if ($filename =~ /(\d+)_(....let)/){ #Specify regex to match filename here
if ($counter != $1) {
$doublet = [@{$data{$filename}}];
$counter = $1;
} elsif ($counter == $1) {
$singlet = [@{$data{$filename}}];
my $C = 27.21138505;	
my @diff = map{
$doublet->[$_]*$C - $singlet->[$_]*$C
}0..$#$doublet;
print "$counter D0-S0 @diff\n";
}
}
}


# Subroutine "slurps" each file in to a single string
# and then parses the relevant data into a hash of arrays

sub load_data {
my $file = $_;
my ($HF, $ZPVE, $fe, $HFZPE);
my $text = do { local( @ARGV, $/ ) = $file ; <> } ;
$text =~ s/\n //g;
foreach ($text =~ m/HF=(-[0-9]+\.[0-9]+)/g) {
$HF=$1;
}
foreach ($text =~ m/ZeroPoint=([0-9]+\.[0-9]+)/g) {
$ZPVE=$1;
}
foreach ($text =~ m/Sum\sof\selectronic\sand\sthermal\sFree\sEnergies=\s+(-[0-9]+\.[0-9]+)/g) {
$fe=$1;
}
$HFZPE=$HF+$ZPVE*$scale_factor;
#print "Processing $file...\n";
push (@{$data{$file}}, ($HF, $HFZPE, $fe));
}
