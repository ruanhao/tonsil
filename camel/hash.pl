#! /usr/bin/perl -w
use CamelUtil;

&test_basis;


## Inner Functions
sub test_basis {
    my %fflint = ("name"  => "flintstone", ## HASH KEYS SHOULD NEVER CONTAIN WHITE SPACE
                  "fname" => "fred", 
                  "job"   => "stonecutter");
    # can also defined as below, but not prefered
    %fflint = ("name", "flintstone", 
               "fname", "fred", 
               "job", "stonecutter");
    my $numOfFflint = keys %fflint; 
    my @keys = keys %fflint; 
    &CamelUtil::dbgprint("\$numOfFflint: $numOfFflint"); 
    while ( ($k, $v) = each %fflint ) {
        &CamelUtil::dbgprint("$k --> $v"); 
    }
    ## it is a good use of hash modification
    @fflint{"name", "fname"} = ("hello", "world");
    foreach ( keys %fflint ) {
        &CamelUtil::dbgprint("$_ --> $fflint{$_}");
    }
}

