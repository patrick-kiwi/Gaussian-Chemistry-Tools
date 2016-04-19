#!/usr/bin/perl
use strict;
use warnings;

# Script written by Patrick O'Connor to extract the
# charge multiplicity and co-ordinates from a log file
# typical usage ./getgeom foo.log > bar.gjf 

my %data;
my $counter1=0;
my $counter2=0;
my $n_atoms=0;
my (@symb, @x, @y, @z);
my ($charge, $multiplicity);

my $filex = glob("$ARGV[0]");

my $in = $ARGV[0];
	open(my $in_FH, "<", $in) 
	or die "cant open file $!";

my $out = $in;
$out =~ s/(.*)\.log$/_NEW_$1.gjf/;
#print "output file is $out\n";

open(my $out_FH, ">", $out) || die "Cant open $out $!\n";

&load_data($in);

while (<$in_FH>) {
chomp;
	if (/.*Charge.*?([0-9]).*?Multiplicity.*?([0-9]).*/) {
	$charge=$1;
	$multiplicity=$2;
	}
	if (/.*Input\sorientation.*/ && $counter1==0) {
	$counter1=1;
	$counter2=0;
	$n_atoms=0;
	}
	if (/\s+-----+?/ && $counter1==1) {
	$counter2++;
	}
	if (/\s-----+?/ && $counter1==1 && $counter2==3) {
	$counter1=0;
	$counter2=0;
	}
	if ($counter1==1 && $counter2==2) {
	next unless (/\s+?[0-9].*/);
	
	do {
		$n_atoms++;
          	my @entries = split;
          	$symb[$n_atoms] = $entries[1];
          	$x[$n_atoms] = $entries[3];
          	$y[$n_atoms] = $entries[4];
          	$z[$n_atoms] = $entries[5];
	}

}

  }
print $out_FH "Geometry generated from $in\n";
print $out_FH "${$data{$in}}[2]\n\n";
print $out_FH "\nHF=${$data{$in}}[0]    ZPVE=${$data{$in}}[1]\n";
print $out_FH "\n$charge $multiplicity\n";


for(my $i = 1; $i <= $n_atoms; $i++) {
  printf $out_FH "%-3s %14.7f %14.7f %14.7f\n",
         $symb[$i],$x[$i], $y[$i], $z[$i];
  }
print $out_FH "\n";



sub load_data {
my $file =  $in;
my ($HF, $ZPVE, $fe, $HFZPE, $routeSection);
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
foreach ($text =~ m/-{50,200}(#.*?)-{50,200}/) {
$routeSection = $1;
}

$HFZPE=$HF+$ZPVE;
print "Processing $file...\n";
push (@{$data{$file}}, $HF  );
push (@{$data{$file}}, $ZPVE);
push (@{$data{$file}}, $routeSection);
}
