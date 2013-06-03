#! /usr/bin/perl -w

use CamelUtil;

## Special Variables
## $& Contains the matching part of the whole string
## $` Contains the left part of the string (before the matching position)
## $' Contains the right part (after the matching position)
## $+ Contains the last match in parentheses

&test_split;

&test_grep;

&test_ref;

&test_greedy;

&read_config;

## Inner Functions

sub test_split {
    ## please note the difference between / / and ' '
    my $string = "   a   b c";
    my @lettersSplash = split / /, $string;
    my @lettersQuote  = split ' ', $string; ## Important
    &CamelUtil::dbgprint("\@lettersSplash: @lettersSplash");
    &CamelUtil::dbgprint("\@lettersQuote: @lettersQuote");
}

sub test_grep {
    my @arr  = qw/ ab abc abcd bc c /;
    my @garr = grep /^a/, @arr;
    &CamelUtil::dbgprint("\@garr: @garr");
}

sub test_ref {
    my $str = "Name:pantani,First Name:Marco,Country:Italy";
    my @arr = ( $str =~ /Name:(.*),First Name:(.*),Country:(.*)/ );
    &CamelUtil::dbgprint("\$1 = $1 \$2 = $2 \$3 = $3");
    for ($i = 0; $i <= $#arr; $i++) {
        &CamelUtil::dbgprint("\$arr[$i] = $arr[$i]");
    }   
}

sub test_greedy {
    my $string = "in a galaxy far, far away";
    if ($string =~ /(f.*r)/) {
        &CamelUtil::dbgprint("greedy: \$1 = $1");
    }
    if ($string =~ /(f.*?r)/) {
        &CamelUtil::dbgprint("not greedy: \$1 = $1");
    }
}

sub read_config {
    our $configEntry = '';
    my  $pattern     = '(a|c)';
    while (<DATA>) {
        if ( /^\s*{\s*$pattern\s*,/ .. /^[^%]*}\./ ) { ## note this usage
            chomp;
            $main::configEntry .= $_;
            if (m/^[^%]*}\s*\./) {    
                &CamelUtil::dbgprint("configEntry: $main::configEntry");
                $main::configEntry = '';
            }    
        }
    }    
}
 

__END__
{a, b}.
{c,
d}.
