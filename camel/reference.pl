#! /usr/bin/perl -w
use CamelUtil;

## 1) A reference to an anonymous array is created with a special notation. The list of values is enclosed in SQUARE BRACKETS.
##    If a backslash is placed in front of a list of values, no single reference is returned. Instead, a list of REFERENCES TO 
##    EACH ELEMENT OF THE LIST is returned.
&test_basis;

## Dereferenciation works with references to anonymous strings. Howevernew values can not 
## be assigned to anonymous SCALARS. They are treated as CONSTANTS.
&test_anonymous;

## To pass two arrays as arguments to a subroutine, there are two possibilities.
## The first option is to pass them by value: func(@a, @b), but then BOTH ARRAYS ARE INTEGRATED IN ONE SINGLE FLAT LIST AND 
## THEIR ORIGINAL STRUCTURE IS LOST.
## The second option, which avoids both disadvantages, is to pass the arrays by reference. A hash may be passed in exactly the same way.
&test_sub(["a", "b"], ["c", "d"]);

## To create a function dispatcher, build anonymous subroutines, store their references in a hash or array, and call them on demand by reference.
## Another possible use of references to subroutines is functions that are dynamically created at runtime.
$fRef = sub { &CamelUtil::dbgprint("$_[0]"); &CamelUtil::dbgprint("anonymous sub") }; ## reference to an anonymous subroutine
&$fRef("hello");
$fRef->("world");

&test_multiple;

## Inner Functions

sub test_anonymous {
    my $ref = \"Tintin anonymous";
    &CamelUtil::dbgprint("$$ref");
    # $$ref   = "Haddock";    ## error

    my $arrayRef = ["dupond", "dupont"];    ## reference to an anonymous array
    my @list  = \("tintin", "milou");    ## references to anonymous scalars: (\"tintin", \"milou")
    my $listRef = \@list;
    &CamelUtil::dbgprint("@$arrayRef");
    &CamelUtil::dbgprint("@{$arrayRef}");
    &CamelUtil::dbgprint("${$arrayRef}[1]");
    &CamelUtil::dbgprint("$$arrayRef[1]");

    $arrayRef->[1] = "hello";   ## ASSIGNED TO ANONYMOUS ARRAY
    &CamelUtil::dbgprint("@$arrayRef");
    &CamelUtil::dbgprint("@$listRef");

    my $hashRef = { hero => "tintin", animal => "milou" }; ## a reference to an anonymous hash
    my @keys = keys %$hashRef;
    &CamelUtil::dbgprint("@keys");
    $hashRef->{hero} = "haddock"; ## ASSIGNED TO ANONYMOUS HASH
    while ( ($k, $v) = each %$hashRef ) {
       &CamelUtil::dbgprint("$k -> $v"); 
    }
}

sub test_basis {
    my $str    = "Tintin";
    my $strref = \$str;
    &CamelUtil::dbgprint("\$\$strref: $$strref");
}

sub test_sub {
    my ($aref, $bref) = @_;
    &CamelUtil::dbgprint("$aref->[1] and $bref->[1]");
}

sub test_multiple {
    my @marr = ([1, 2], [5, 6], [8, 9]);
    &CamelUtil::dbgprint("${$marr[2]}[1]");
    &CamelUtil::dbgprint("$marr[2]->[1]");
    &CamelUtil::dbgprint("$marr[2][1]");

}
