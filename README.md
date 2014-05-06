Gaussian Perl Tools

These are some tools I've created for myslef to speed up processing of gjf input and log output files.  Perhaps you'll find them useful. They're pretty "rough and ready", so you'll need to adjust the source code on the fly.  Here are the most useful programs I've made so far.

1>> maniuplateGJF.pl XXX.gjf   
This program changes both the file name and the file content.  First, it strips out everything before charge and multiplicity line.  At the moment it's configured to covert (for examele) 415.gjf to 415_singlet.gjf and 415_doublet.gjf (charges and multiplicities are changed as per the filename)   This is obvioulsy useful if you want to create a massive batch of input files for batch processing.  You can modify the REGEX to increment the numbers in the filename if you like.  Note, If the gjf files have come from windows make sure to use dos2unix.

2>> process_logfile.pl  
This program "slurps" the entire log file into a single string.  This is really important because some output flows over multiple lines. Program then pattern matches to find (for instance) HF, ZPE, Gibbs free energy, etc.  Then prints the output filename.log HF, ZPE, FE etc.  Note I've hard coded the file selection in the line beginning with my @files.  You can change the fileglobbing if you wish, ie glob"31[5-9]_singlet.log".  Again make sure you use dos2unix if the log file came from windows.  The output data looks like this..

 "409_doublet.log -970.7015063 0.2122021 -970.4893042 -970.529732"



3>> process_logfile_extended.pl

Imagine you had hyndreds of files in pairs like 415_singet.log and 415_doublet.log
You want perl to extract the data, but take difference between doublet and singlet electronic energy.  You want perl to print the singlet doublet data for each file number on a single line because that's easy to work with in excel.  The output data would look like this (just capturing electronic energy here).

 "476_doublet.log doublet -1085.2256596 singlet -1085.0870699"



