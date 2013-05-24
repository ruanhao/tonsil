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

## When a test is performed, Perl uses the 'stat(3)' system call to store the complete list 
## of information from the 'inode'. If multiple tests are needed for a particular file, 
## then 'stat' is called each time, unless _ is used. Using _ in a script tells Perl to use 
## the 'inode' information from the last call. This both simplifies the code and provides a performance 
## benefit by avoiding repeated system calls to 'stat'
&test_stat;

## Test permissions
## Some operators are not limited to true/false return values. With the -s operator, the 
## size of a file is returned.
&test_permission;

## File-name globbing is a method Perl uses for getting directory contents.
## With globbing, a file-name pattern is specified in angle brackets. The pattern can 
## contain shell wildcards, such as * or ?. When executed, Perl opens a shell in the background 
## and assigns the pattern to it. The shell then resolves the pattern and returns the list of 
## matching file names to Perl.
&test_glob;




### Inner Functions

sub test_permission {
    my $file = "./hashfile.txt";
    if (-e $file) {
        &CamelUtil::dbgprint("$file is readable")   if (-r _);
        &CamelUtil::dbgprint("$file is writable")   if (-w _);
        &CamelUtil::dbgprint("$file is executable") if (-x _);
    }
    &CamelUtil::dbgprint("The size of $file: " . (-s _) . " bytes");    ## Note this
}

sub test_file_exist {
    my $file = "./hashfile.txt";
    if (-e $file) {
        &CamelUtil::dbgprint("$file exists");
    } else {
        &CamelUtil::dbgprint("$file not exists");
    }
}

sub test_stat {
    my $file = "./hashfile.txt";
    -e $file or die "File does not exist. \n";
    -w _ or die "File is not writable. \n";
    &CamelUtil::dbgprint("$file exists and is writeable.");

    ($dev, $ino, $mode, $nlink, $uid, $gid, $rdev, $size, $atime, $mtime, 
     $ctime, $blksize, $blocks) = stat $file or die "Unable to stat $file: $!\n";
    &CamelUtil::dbgprint("dev:               $dev");
    &CamelUtil::dbgprint("inode:             $ino");
    &CamelUtil::dbgprint("mode:              $mode");
    &CamelUtil::dbgprint("# of links:        $nlink");
    &CamelUtil::dbgprint("uid:               $uid");
    &CamelUtil::dbgprint("gid:               $gid");
    &CamelUtil::dbgprint("rdev:              $rdev");
    &CamelUtil::dbgprint("size:              $size");
    &CamelUtil::dbgprint("last access time:  $atime");
    &CamelUtil::dbgprint("last modify time:  $mtime");
    &CamelUtil::dbgprint("inode change time: $ctime");
    &CamelUtil::dbgprint("block size:        $blksize");
    &CamelUtil::dbgprint("blocks:            $blocks");
}

sub test_glob {
    for (sort <./*>) {  ## Note this
        &CamelUtil::dbgprint;
    }
}
