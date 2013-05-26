#! /usr/bin/perl -w
###############################################################################
### 1) Perl performs all the reading or writing of data in the background.
###    A few predefined filehandles, such as STDIN or STDOUT, are automatically
###    opened by Perl. Others must be opened by you.
###############################################################################
use strict;
#use lib ".";

#use autodie; #automatically detect I/O errors

use CamelUtil;

### The actual error detected by Perl can be passed to the 'die' function using 
### the $! variable.
### open FILE, "<badfile.txt" or die "Open failed: $!\n";

### The following script reads data, assigns it to a hash, and print out the 
### results.
&test_read;

### A predefined filehandle similar to <STDIN> is DATA.
### The data is denoted by the marker __END__.
&test_enddata;

### Usually 'print' outputs its argument list sequentially with no space between 
### elements and without a \n at the end.
### The behaviour of 'print' can be changed with $, and $\. The $, is the 
### separator between elements, and $\ specifies the trailing character.
my $commaOld  = $,;
my $revSplash = $\;
$, = "--";
$\ = "\n";
&test_print;
$, = $commaOld;
$\ = $revSplash;

### Filehandle can be connected to processes. Using filehandles to read the output 
### of a command is very similar to using back quotes.
&test_pipe;











### Inner Function

sub test_pipe {
    open LS, "ls -l |";
    while (<LS>) {
        chomp;
        &CamelUtil::dbgprint;
    }
    close LS;

    open WC, "| wc -l";
    my @arr = ("a\n", "b\n", "c\n");
    for (@arr) {
        print WC;
    }
    close WC; ## flush the buffer
}

sub test_print {
    print (1, 2, 3);
}

sub test_enddata {
    my @lines = <DATA>;
    for (@lines) {
        chomp;
        &CamelUtil::dbgprint;
    }
}

sub test_read {
    open FILE, "<./hashfile.txt" or die "Open failed: $!\n";
    my %hash = ();
    while (<FILE>) {
        chomp;
        my ($key, $value) = split /::/;
        $hash{$key}       = $value;
    }
    for (keys %hash) {
        &CamelUtil::dbgprint("$_ -> $hash{$_}");
    }
    close FILE;
}


__END__
hello
world
China
Shanghai
Changning
