#! /bin/bash
dbgecho() 
{
    ## printf "#%-30s @%-8s --- $1\n" $3 $2
    ## echo "#$3, @line:$2 --- $1"
    a=$( caller 0 )
    OldIFS="$IFS"
    IFS=" "
    arr=( $a )
    IFS="$OldIFS"
    local line=${arr[0]}
    local func=${arr[1]}
    printf "#%-30s @%-8s --- $1\n" $func $line
}
