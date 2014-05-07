#!/usr/bin/perl

#Script written by Dr Patrick O'Connor patrick_kiwi@hotmail.com
#Auckland Cancer Socitry Research Centre (New Zealand)
#Feel free to use as you wish.

use strict;
use warnings;

my %data; 	#Global varyable, the HoA data container


my @files = glob("47[3-9]*let.log 4[8-9][0-9]*let.log");
foreach (@files) {
&load_data();  	#loads energies etc into data container
}


my $counter = 0;
for my $filename (sort keys %data){
if ($filename =~ /(\d+)_(....let)/){
if ($counter != $1) {
print "$1 $2 @{$data{$filename}} ";
$counter = $1;
} elsif ($counter == $1) {
print "$2 @{$data{$filename}}\n";
}
}
}


# Subroutine "slurps" each file so a single string
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
$HFZPE=$HF+$ZPVE;
#print "Processing $file...\n";
push (@{$data{$file}}, ($HF));
}

