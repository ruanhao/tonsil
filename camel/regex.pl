#! /usr/bin/perl -w

use CamelUtil;


&test_split;

&test_grep;

&test_ref;

&test_greedy;

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