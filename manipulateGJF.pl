#!/usr/bin/perl

# Author Dr Patrick D. O'Connor, Auckland Cancer Society Research Centre
# patrick_kiwi@hotmail.com
# strips the route section and make 2 copies (singlet and doublet)
# ready for batch processing
# usage manipulateGJF test.gjf

my $in = $ARGV[0];
if (! defined $in) {
        die "Error! - INCORRECT  USAGE: $0 filename";
}
my $out_singlet = $in;
$out_singlet =~ s/(\d+)\.gjf/$1_singlet.gjf/;

my $out_doublet = $in;
$out_doublet =~ s/(\d+)\.gjf/$1_doublet.gjf/;


if (! open $in_fh, '<', $in ) {
        die "Error! - cant open '$in' : $!";
}

if (! open $out_fh_singlet, '>', $out_singlet ) {
        die "Error! cant write '$out' : $!";
}

if (! open $out_fh_doublet, '>', $out_doublet ) {
        die "Error! cant write '$out' : $!";
}

# This loop deletes everything upto the charge & spin multiplicity line
# Then puts a title, newline, and a charge/spin place holder
# finally substitute charge spin for whatever you want then write to 
# one or more output files
# Note - the way I do my batch files I start with a blank line then the title
# Of course you might want to change that depending on how you insert your route section.

my $counter = 0;
foreach (<$in_fh>) {
if ($counter==0) {  
if (/.*[0-9] [0-9]\n/) { #look for charge multiplicity
$counter=1; # change counter and insert stuff
s/(.*[0-9] [0-9]\n)/\nCoordinates from $in\n\nPlace Holder\n/;
} else {
s/.*?\n//e; #otherwise delete everyting
}
}

s/Place Holder\n/1 1\n/;
print $out_fh_singlet $_;
s/1 1\n/0 2\n/;
print $out_fh_doublet $_;
}
