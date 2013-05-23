#! /usr/bin/perl -w
###############################################################################
### 1) Perl performs all the reading or writing of data in the background.
###    A few predefined filehandles, such as STDIN or STDOUT, are automatically
###    opened by Perl. Others must be opened by you.
###############################################################################
use strict;
#use lib ".";

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
















### Inner Function

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
shanghai
