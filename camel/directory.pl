#! /usr/bin/perl -w

# use strict;
use lib ".";

use CamelUtil;

### Genenal File and Directory Operators
### -A Access age in days
### -b Entry is a block-special file
### -B File is binary
### -c Entry is a character-special file
### -C inode modification age in days
### -d Entry is a directory
### -e File or directory exists
### -f Entry is a plain file
### -g File or directory is 'setgid'
### -k File or directory has Sticky Bit set
### -l Entry is a symbolic link
### -M Modification age in days
### -p Entry is a named pipe
### -s File or directory exists and has a non-zero size
### -S Entry is a socket
### -T Entry is text
### -u File is 'setuid'
### -z File exists and has zero size


### File and Directory Permission Operators
### -o File or directory is owned by the user
### -O File or directory is owned by the real user
### -r File or directory is readable 
### -R File or directory is readable by the real user
### -w File or directory is writable 
### -W File or directory is writable by the real user
### -x File or directory is executable
### -X File or directory is executable by the real user

## Perl offers specific file and directory test operators, similar to 
## those found in UNIX shells.
&test_file_exist;







### Inner Functions

sub test_file_exist {
    my $file = "./hashfile.txt";
    if (-e $file) {
        &CamelUtil::dbgprint("$file exists");
    } else {
        &CamelUtil::dbgprint("$file not exists");
    }
}
