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

