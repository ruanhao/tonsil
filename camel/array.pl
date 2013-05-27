#! /usr/bin/perl -w

use lib ".";
use CamelUtil;

### 1) We can not directly manipulate Array or Hash like chmop((("a ", "b ")[1]));, this will cause an error.
###    And 'push ("a", "b"), "c";' is also meaningless.
###    I think Array and Hash are somewhat 'Literal', if you want to operate on them, assign them to a viarable.
###    Then Perl will memset the viarable that Perl can operate on.
###    This also makes sense why 'chomp(<STDIN>);' is illegal.
### 2) In Perl programming, excessive and unnecessay use of parentheses and other punctuation is explicitly deprecated. 
###    When no variable is specified in a for statement, $_ is assumed.



&test_substr;

&test_case;

&test_copy;

&test_qw;

&test_slice;

&test_sort;

## Inner Functions

sub test_substr {
    my $str = "i am in shanghai";
    substr($str, 8, 8) = "fujian";
    &CamelUtil::dbgprint("$str");   ## i think substr() directly return a (char *)
                                    ## but if the return value is assigned to a scalar variale, 
                                    ## it becomes a real scalar variable.
}

sub test_case {
    my $option = 2;
    {   ## this is the curly brace that 'last' jump out of
        ($option == 1) && do { &CamelUtil::dbgprint("$option"); last };     ## remember this usage, there is no ';' at the end of 'last', 
                                                                            ## and there is a ';' at the end of '}'
                                                                            ## 'last' jumps out to the curly braces that have no trailing ';'
        ($option == 2) && do { &CamelUtil::dbgprint("$option"); last; };    ## the ';' after 'last' can be omitted.
        ($option == 3) && do { &CamelUtil::dbgprint("$option") };           ## i think 'do' is always statement syntax, not block syntax.
                                                                            ## so we should put a ';' at the end of the statement, even in
                                                                            ## 'do while' cases where 'while' only acts as condition judgement.
    }
}

sub test_copy {
    my @consecutiveArr = (1 .. 10);    ## 1, 2, 3 is also an array, no need to add parenthese.
                                       ## but since '=' has high priority, so sometimes parenthese is needed.
                                       ## print sort 1, 5, 3, 2, 4, 6 -> 123456
    my @consecutiveArrCopy = @consecutiveArr; 
    $consecutiveArrCopy[0] = 333; 
    &CamelUtil::dbgprint("\@consecutiveArrCopy: @consecutiveArrCopy");
    &CamelUtil::dbgprint("\@consecutiveArr: @consecutiveArr");
}

sub test_qw {
    my @qwArr = qw/ shanghai fujian beijing /;  ## it just prints what you see, 
                                                ## qw/ "$a" "$b" "$c"/ -> "$a" "$b" "$c"
    &CamelUtil::dbgprint("\@qwArr: @qwArr");
}

sub test_slice {
    my @arr = ("mercury", "venus", "earth", "mars");
    &CamelUtil::dbgprint("\@arr: @arr");
    ## slice
    my @sliceA = @arr[1, 3];
    &CamelUtil::dbgprint("\@sliceA: @sliceA");
    ## consecutive slice
    my @sliceB = @arr[0 .. 2];
    &CamelUtil::dbgprint("\@sliceB: @sliceB");
    ## slice modification
    @arr[0, 1, 3] = ("jupiter", "neptune", "pluto");
    &CamelUtil::dbgprint("\@arr: @arr");
    ## slice swap
    @arr[1, 3] = @arr[3, 1];
    &CamelUtil::dbgprint("\@arr: @arr");
}

sub test_sort {
    my @arr = qw/ bb aa dd cc 1 12 2 23 4 /;
    my @defaultSort = sort @arr;
    &CamelUtil::dbgprint("\@defaultSort: @defaultSort");
    my @asciiSort = sort { $a cmp $b } @arr;
    &CamelUtil::dbgprint("\@asciiSort: @asciiSort");
    @arr = qw/ 1 3 2 5 4 8 6 9 7 /;
    my @intSort = sort { $a <=> $b } @arr;
    &CamelUtil::dbgprint("\@intSort: @intSort");
    my @intSortR = sort { $b <=> $a } @arr;
    &CamelUtil::dbgprint("\@intSortR: @intSortR");

    @arr = qw/1.0 1 12 12.0 2 23 4/;
    my @sortstrnum = sort { $a <=> $b || $a cmp $b } @arr; ## this usage is good, pls take note
    &CamelUtil::dbgprint("\@sortstrnum: @sortstrnum");
}

