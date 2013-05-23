#! /usr/bin/perl -w

#############################################
### 1) A subroutine is always a part of some 
###    expression and, therefore, must return 
###    a value.
###    The value returned is either the value 
###    passed in the return statement or the 
###    value returned by the last expression 
###    evaluated in the subroutine.
### 2) There are two special code blocks in 
###    Perl that control when a piece of code 
###    is compiled or executed.
###    In a BEGIN { ... } block, all commands 
###    are executed at compile time. 
###    In a END { ... } block, all commands are 
###    executed after a subroutine or the main
###    program is aborted, even if the program 
###    is terminated by 'die'.
###    So, when using Module, a BEGIN block is 
###    often used: 
###    BEGIN { unshift @INC, "/some/path/" };
#############################################

# use strict;
use lib ".";

use CamelUtil;

### The 'local' statement broadens the scope of variables. 
### In addition to being visible in a subroutine, 'local' 
### variable are also visible in subroutines called from 
### within the block in which they are declared.
&test_local;

### A context-sensitive subroutine returns the correct data 
### type whether it is in a scalar or list context.
$len = &test_context("a:b:c");
@arr = &test_context("a:b:c");
&CamelUtil::dbgprint("\$len: $len");
&CamelUtil::dbgprint("\@arr: @arr");

### Configuration can be realized like this:
&test_config;


### Inner Routines
sub test_context {
    my $str = $_[0];
    @str = split /:/, $str;
    my $len = @str;
    return @str if wantarray;
    return $len;
}

sub test_local {
    my $var = "hello";
    &outter;
}

sub outter {
    local $lvar = "shanghai";
    &inner;
}

sub inner {
    ## &CamelUtil::dbgprint("\$var: $var");
    &CamelUtil::dbgprint("\$lvar: $lvar");
}

sub test_config {
    $CamelUtil::config = 12345; # here, config is set, 
                                # $config should be global.
    &CamelUtil::show_config;
}
