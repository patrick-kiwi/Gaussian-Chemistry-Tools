Gaussian Perl Tools

These are some tools I've created for myslef to speed up processing 
of gjf input and log output files.  Perhaps you'll find them useful.
They're pretty "rough and ready", so you'll need to adjust the source 
code on the fly.  Here are the most useful.

1>> maniuplateGJF.pl XXX.gjf   
This program changes both the file name and the
file content.  It strips out everything before charge and multiplicity line. 
At the moment it's configured to covert (for examele) 415.gjf to 
415_singlet.gjf and 415_doublet.gjf (charges and multiplicities changed
as the filename suggest)   This is obvioulsy useful if you want to create
a massive batch of input files.  You can modify the code to increment the 
numbers in the filename if you like.  Note, If the gjf files have come from windows
make sure you use dos2unix.

2>> process_logfile.pl  
This program "slurps" the entire log file into a single
string.  This is really important because some output flows over multiple lines.
Program then pattern matches to find (for instance) HF, ZPE, Gibbs
free energy, etc.  Then prints the output filename.log HF, ZPE, FE etc.
Note I've hard coded the file selection in the line beginning with my @files
you can change the fileglobbing if you wish, ie glob"31[5-9]singlet.log"  
Again make sure you use dos2unix if the log file came from windows.  The output data looks like this..

 409_doublet.log -970.7015063 0.2122021 -970.4893042 -970.529732
 409_singlet.log -970.5625598 0.2153109 -970.3472489 -970.386716
 410_doublet.log -1062.9499218 0.2110176 -1062.7389042 -1062.781975
 410_singlet.log -1062.8026542 0.2138493 -1062.5888049 -1062.631302
 411_doublet.log -1062.9495844 0.2109446 -1062.7386398 -1062.781356
 411_singlet.log -1062.8010978 0.2136309 -1062.5874669 -1062.630001
 412_doublet.log -970.6992023 0.2122718 -970.4869305 -970.527381



3>> process_logfile_extended.pl
Imagine you had hyndreds of files in pairs like 415_singet.log and 415_doublet.log
You want perl to extract the data, but take difference between doublet and singlet electronic energy.  You want perl to print the singlet doublet data for each file number on a single line so you want work with it in an excel spread sheet.  The output data would look like this (just capturing electronic energy here).

476_doublet.log doublet -1085.2256596 singlet -1085.0870699
477_doublet.log doublet -1026.055246 singlet -1025.9221588
478_doublet.log doublet -1101.2538211 singlet -1101.1252639
479_doublet.log doublet -722.5365178 singlet -722.3967459
480_doublet.log doublet -797.7467458 singlet -797.6059819
481_doublet.log doublet -703.0564708 singlet -702.9213934


