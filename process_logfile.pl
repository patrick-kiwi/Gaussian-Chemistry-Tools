#!/usr/bin/perl
#usage process_logfile  ## this will process all *.log files see the glob line below


my %data; 	#Global variable, the HoA data container

#loads energies etc into data container
my @files = glob("*.log");
foreach (@files) {
&load_data();  	
}


#Perl sorts through the HoA and print all the data
for my $filename (sort keys %data){
print "$filename @{$data{$filename}}\n ";
}


# Subroutine "slurps" each file in to a single string
# and then parses the relevant data into a hash of arrays
sub load_data {
my $file = $_;
my ($HF, $ZPVE, $FreeEnergy, $HFZPVE);
my $text = do { local( @ARGV, $/ ) = $file ; <> } ;
$text =~ s/\n //g;
foreach ($text =~ m/HF=(-[0-9]+\.[0-9]+)/g) {
$HF=$1;
}
foreach ($text =~ m/ZeroPoint=([0-9]+\.[0-9]+)/g) {
$ZPVE=$1;
}
foreach ($text =~ m/Sum\sof\selectronic\sand\sthermal\sFree\sEnergies=\s+(-[0-9]+\.[0-9]+)/g) {
$FreeEnergy=$1;
}
$HFZPVE=$HF+$ZPVE;
#print "Processing $file...\n";
push (@{$data{$file}}, ($HF, $ZPVE, $HFZPVE, $FreeEnergy));
}
