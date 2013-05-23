package CamelUtil;

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
