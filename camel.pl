#! /usr/bin/perl -w
$" = "--"; ## special variable used as seperator between list elements
print "hello", "world", "\n";
## print "hello" + "world" + "\n"; => wrong
print 100   + 100,   "\n";
print "100" + "100", "\n";

$a = "hello" .  "world";
print $a, "\n";
$b = "i am in Shanghai \n";
$c = "i am in Shanghai \n";
substr($b, 8, 8) = "Fujian"; ## i think substr() directly return a (char *)
                             ## but if the return value is assigned to a scalar variale, 
                             ## it becomes a real scalar variable.
$substrC = substr($c, 8, 8);
$substrC = "China";
$substr = "Fujian";
print $substr, "\n";
print $b, "\n";
print $c, "\n";


print "=" x 20 . "\n";
$var = 3;
{
    {
        ($var == 1) && do { print "1111111\n"; last }; ## remember this usage, there is no ';' at 
                                                       ## the end of 'last', and there is a ':' at 
                                                       ## the end of '}'
        ($var == 2) && do { print "2222222\n"; last }; 
        ($var == 3) && do { print "3333333\n"; $var = 33 }; ## i think 'do' is always statement syntax, not block syntax.
                                                            ## so we should put a ';' at the end of the statement, even in                                                            ## 'do while' cases where 'while' only acts as condition
                                                            ## judgement.
        print "Inner\n"; 
    }
    print "Outter\n";
}
print $var, "\n";


#### Test Array ########
@consecutiveArr = (1 .. 10);    ## 1, 2, 3 is also an array, no need to add parenthese.
                                ## but since '=' has high priority, so sometimes parenthese is needed.
                                ## print sort 1, 5, 3, 2, 4, 6 -> 123456
@consecutiveArrCopy = @consecutiveArr; 
$consecutiveArrCopy[0] = 333; 
print "\@consecutiveArrCopy: @consecutiveArrCopy \n"; 
print "\@consecutiveArr: @consecutiveArr \n"; 
@qwArr = qw/shanghai fujian beijing/; ## it just prints what you see, 
                                ## qw/"$a" "$b" "$c"/ -> "$a" "$b" "$c"
print @qwArr, "\n"; 
print "The last index of \@consecutiveArr is $#consecutiveArr \n"; 
$consecutiveArrLength = @consecutiveArr; ## it is ok, in this context, the array length is returned. 
print "The length of \@consecutiveArr is: $consecutiveArrLength\n"; 
foreach $i (@qwArr) ## have to add parenthesis
{
    print $i, "\n"; 
}
for $i (@qwArr) 
{
    print "In for: $i \n";
}
for (@qwArr) 
{
    print "For nothing: $_ \n"; 
}
####################################################################################################################
## In Perl programming, excessive and unnecessay use of parentheses and other punctuation is explicitly deprecated.# 
## When no variable is specified in a for statement, $_ is assumed.                                                #
@arr = ("mercury", "venus", "earth", "mars");                                                                      #
print "The array contains the following elements: \n";                                                             #
foreach (@arr)  ## Implies that $_ is the variable that will be operated on.                                       #
{                                                                                                                  #
    print;  ## Implies the current array element.                                                                  #
    print "\n"; 
}                                                                                                                  #
####################################################################################################################

@arra = ("mercury", "venus", "earth", "mars");
## slice 
@sliceA = @arra[1, 3]; 
print "\@sliceA: @sliceA\n"; 
## consecutive slice
@sliceB = @arra[0 .. 2]; 
print "\@sliceB: @sliceB\n"; 
## slice modification
@arra[0, 1, 3] = ("jupiter", "neptune", "pluto"); 
print "\@arra: @arra\n"; 
## slice swap
@arra[1, 3] = @arra[3, 1]; 
print "\@arra: @arra\n"; 
## please note the difference between / / and ' '
$string = "  a   b c"; 
@lettersSplash = split / /, $string; 
@lettersQuote = split ' ', $string; 
print "\@lettersSplash: @lettersSplash\n"; 
print "\@lettersQuote: @lettersQuote\n"; 

@arr = qw/bb aa dd cc 1 12 2 23 4/; 
@sortarr = sort @arr; 
print "The sorted list is: @sortarr\n"; 
@sarr = sort { $a cmp $b } @arr; ## { $a cmp $b } is sort of anonymous function
print "The sorted list is: @sarr\n"; 
@arr = qw/1 3 2 5 8 6 9/; 
@iarr = sort { $a <=> $b } @arr; 
print "The sorted list is: @iarr\n"; 
@iarrr = sort { $b <=> $a } @arr; 
print "The sorted list is: @iarrr\n"; 
## if want to sort strings and numbers, use the snippet below:
@arr = qw/1.0 1 12 12.0 2 23 4/;
@sortstrnum = sort { $a <=> $b || $a cmp $b } @arr; ## this usage is good, pls take note
print "The sorted list is: @sortstrnum\n"; 

@arr = qw/ab abc abcd bc c/;
@garr = grep /^a/, @arr;
print "\@garr: @garr\n";

$file = `ls`;
@file = `ls`;
print "\$file: $file\n"; 
print "\@file: @file\n"; 

############# Hash #####################
%fflint = ("name"  => "flintstone", ## HASH KEYS SHOULD NEVER CONTAIN WHITE SPACE
           "fname" => "fred", 
           "job"   => "stonecutter");
# can also defined as below, but not prefered
%fflint = ("name", "flintstone", 
           "fname", "fred", 
           "job", "stonecutter");
$numOfFflint = keys %fflint; 
@keys = keys %fflint; 
print "\$numOfFflint: $numOfFflint\n"; 
print "\@keys: @keys\n"; 
while ( ($k, $v) = each %fflint ) {
    print "$k --> $v\n"; 
}

## it is a good use of hash modification
@fflint{"name", "fname"} = ("hello", "world");
foreach ( keys %fflint ) {
    print "$_ --> $fflint{$_}\n";
}

