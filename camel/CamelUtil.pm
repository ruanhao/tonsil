package CamelUtil;



## Utilities
## 1) if set $| = 1, then Perl will flush stdout without buffering.


$config = 54321;

sub show_config {
    &dbgprint($config);
}

sub dbgprint {
    my $string = (defined $_[0]) && $_[0] || $_;
    my ($_pkg, $fname, $line) = caller;
    printf "\@%-15s #%-3s ======= %s\n", ($fname, $line, $string);
}
1;
