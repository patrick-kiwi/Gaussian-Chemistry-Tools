#!/usr/bin/perl
use strict;
use warnings;

# Script written by Patrick O'Connor to extract the
# charge multiplicity and co-ordinates from a log file
# typical usage ./getgeom foo.log > bar.gjf 

my $counter1=0;
my $counter2=0;
my $n_atoms=0;
my (@symb, @x, @y, @z);
my ($charge, $multiplicity);

my $in = $ARGV[0];
	open(my $in_FH, "<", $in) 
	or die "cant open file $!";

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

print "\nGeometry generated from $in\n\n$charge $multiplicity\n";
for(my $i = 1; $i <= $n_atoms; $i++) {
  printf "%s %16.7f %16.7f %16.7f\n",
         $symb[$i],$x[$i], $y[$i], $z[$i];
  }
print "\n";
