Gaussian Perl Tools

These are some tools I've created for myself to speed up processing of gjf input and log output files.  Perhaps you'll find them useful. They're pretty "rough and ready", so you'll need to adjust the source code on the fly.  Here are the most useful programs I've made so far.

1>> getgeom.pl foo.log > bar.gjf
This script extracts the final coordinants including charge and multiplicity from the log file and stuffs in into a new gjf file, ready for further batch processing.

2>> maniuplateGJF.pl foo.gjf   
This program changes both the file name and the file content and outputs a new modified file.  First, it strips out everything before charge and multiplicity line.  At the moment it's configured to covert (for example) 415.gjf to 415_singlet.gjf and 415_doublet.gjf (charges and multiplicities are changed as the filename suggests)   This is obviously useful if you want to create a massive batch of input files for batch processing.  You can modify the REGEX to increment the numbers in the filename if you like.  Note, If the gjf files have come from windows make sure to use dos2unix.

3>> process_logfile.pl  
This program "slurps" the entire log file into a single string.  This is really important because some output flows over multiple lines. Perl then pattern matches over the string to find (for instance) HF, ZPE, Gibbs free energy, etc.  This data is then loaded into an array.  If more than one instance of the pattern is matched in the string( ie file) then you get overwrite so you capture the last instance of the match.  Finally perl prints the output filename.log HF, ZPE, FE etc.  Note I've hard coded the file selection in the line beginning with my @files.  You can change the fileglobbing if you wish, ie glob"31[5-9]_singlet.log".  Again make sure you use dos2unix if the log file came from windows.  The output data looks like this..

 "409_doublet.log -970.7015063 0.2122021 -970.4893042 -970.529732"



4>> process_logfile_extended.pl  
Imagine you had hundreds of paired files with a common filename pattern, for instance -> 415_singet.log and 415_doublet.log
You want perl to extract all the data in a way where the singlet and doublet data to appear on a single line because that's easy to work with in excel.  This script makes the output look like this (just capturing electronic energy here).

 "415 doublet -1085.2256596 singlet -1085.0870699"



