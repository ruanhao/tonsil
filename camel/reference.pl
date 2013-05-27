#! /usr/bin/perl -w
use CamelUtil;


my $aref = ["dupond", "dupont"];
&CamelUtil::dbgprint("$aref->[0]");
$aref->[1] = "tournesol";
&CamelUtil::dbgprint("$aref->[1]");
