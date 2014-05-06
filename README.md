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
Again make sure you use dos2unix if the log file came from windows.


Apologies if coding is a bit crappy.  I'm self taught.
