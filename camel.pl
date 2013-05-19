#! /usr/bin/perl -w
print "hello", "world", "\n";
## print "hello" + "world" + "\n"; => wrong
print 100   + 100,   "\n";
print "100" + "100", "\n";

$a = "hello" .  "world";
print $a, "\n";
$b = "i am in Shanghai", "\n";
$c = "i am in Shanghai", "\n";
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
        ($var == 3) && do { print "3333333\n"; $var = 33 }; 
        print "Inner\n"; 
    }
    print "Outter\n";
}
print $var;


