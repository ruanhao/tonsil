#! /bin/bash

clear

dbgecho() 
{
    printf "#%-30s @%-8s --- $1\n" $3 $2
    #echo "#$3, @line:$2 --- $1"
}

test_local()
{
    local a
    a=12345
    dbgecho "local a: $a" $LINENO $FUNCNAME
}

test_background_loop() 
{
    for i in "a" "b" "c"; do
        dbgecho "background loop: $i" $LINENO $FUNCNAME
    done &
}

test_brace_redirection() 
{
    local l1
    local l2
    local l3
    local file="/root/braces.txt"
    {
        echo "hello"
        echo "world"
        echo "haha between braces"
    }>$file
    dbgecho "write ok" $LINENO $FUNCNAME
    {
        read l1 ## should not write as read $l1
        read l2
        read l3
    }<$file
    dbgecho "$l1, $l2, $l3" $LINENO $FUNCNAME
}

help()
{
    ## we can not put whitespace before EOF
    cat <<EOF
    Script name: `basename $0`
    Some snippets of Shell.
    Sort of useless.
EOF
}


help

test_boolean_and_parameter() 
{
    file="/bin/vi"
    if [ -f "$file" ]; then
        dbgecho "$file exists" $LINENO $FUNCNAME
    fi

    if [ "$file" = "/bin/vi" ]; then
        dbgecho "two virables equal" $LINENO $FUNCNAME
    fi

    ## clause between {} is called 'anonymous function'
    [ -f "$file" ] && dbgecho "$file exists" $LINENO $FUNCNAME || \
        { dbgecho "$file does not exists" $LINENO $FUNCNAME; exit 1; } 

    [[ -n "$1" ]] && dbgecho "\$1 is defined: $1" $LINENO $FUNCNAME || \
        dbgecho "\$1 is not defined" $LINENO $FUNCNAME
    [ -n "$2" ] && dbgecho "\$2 is defined: $2" $LINENO $FUNCNAME || \
        dbgecho "\$2 is not defined" $LINENO $FUNCNAME

    local nArgs=$#
    dbgecho "number of args: $nArgs" $LINENO $FUNCNAME
    local lastArg=${!nArgs}    # ${!#} is prefered :)
    dbgecho "last arg: $lastArg" $LINENO $FUNCNAME

    local enter="/root/"
    if cd $enter 2> /dev/null; then
        dbgecho "enter new dir" $LINENO $FUNCNAME
        for item in $enter/*; do    ## take a look at the usage: $enter/*
            dbgecho "item: $item" $LINENO $FUNCNAME
        done
    else
        dbgecho "entering dir fails" $LINENO $FUNCNAME
    fi


}

test_loop() 
{
    zipFile="/root/test.tar.gz"
    if [ -f $zipFile ]; then 
        case $( file $zipFile ) in 
            *"Zip archive"* )
                dbgecho "zip archive" $LINENO $FUNCNAME;;
            *"gzip compressed"* )
                dbgecho "gzip archive" $LINENO $FUNCNAME;;
            *"bzip2 compressed"* ) 
                dbgecho "bzip2 archive" $LINENO $FUNCNAME;;
            * ) 
                dbgecho "undef" $LINENO $FUNCNAME;;
        esac
    else 
        dbgecho "$zipFile does not exists" $LINENO $FUNCNAME
    fi

    ## {1..3} can be replaced by "1" "2" "3"
    for i in {1..3}; do 
    dbgecho "$i" $LINENO $FUNCNAME
    done

    for (( i=0;i<3;i++ )); do
        dbgecho "$i" $LINENO $FUNCNAME
    done
}

################################
## ':' is equivalent to 'true'##
## while :                     #
## do                          #
##     something               #
## done                        #
########### equals to: #########
## while true                  #
## do                          # 
##     something               #
## done                        #
################################
## or ':' can be seem as a nop #

test_algorithm() 
{
    dbgecho $(( 2#101010 )) $LINENO $FUNCNAME

    ## ',' links a series of math op, last op is returned
    dbgecho $(( 1+2,2+3 )) $LINENO $FUNCNAME
}

test_string() 
{
    local str="hello world"
    dbgecho "length of str: ${#str}" $LINENO $FUNCNAME

    dbgecho "substr to end: ${str:6}" $LINENO $FUNCNAME
    dbgecho "slice substr: ${str:6:3}" $LINENO $FUNCNAME    ## the same as: echo | awk '{printf substr("'"$str"'", 3, 4) "\n"}'
                                                            ## take note: echo is used to generate a fake input so as not to offer a file to awk
                                                            ## take note: "'"$str"'"
    dbgecho "substr from backend: ${str:(-6)}" $LINENO $FUNCNAME
    dbgecho "subtract paras to the end (*): ${*:3}" $LINENO $FUNCNAME  
    ## dbgecho "subtract para (@): ${@:3}" $LINENO $FUNCNAME ## look at the difference in the stdout :) 
    dbgecho "subtract paras like slice: ${*:3:2}" $LINENO $FUNCNAME  
    dbgecho "cut str from left (not greedy): ${str#h*l}" $LINENO $FUNCNAME  
    dbgecho "cut str from left (greedy): ${str##h*l}" $LINENO $FUNCNAME  
    dbgecho "cut str from right (not greedy): ${str%l*}" $LINENO $FUNCNAME  
    dbgecho "cut str from right (greedy): ${str%%l*}" $LINENO $FUNCNAME  
    dbgecho "replace str once: ${str/l/o}" $LINENO $FUNCNAME  
    dbgecho "replace str all: ${str//l/o}" $LINENO $FUNCNAME  
    dbgecho "replace str from head: ${str/#he/she}" $LINENO $FUNCNAME  
    dbgecho "replace str from end: ${str/%ld/lllllld}" $LINENO $FUNCNAME  
    dbgecho "default value (unset): ${unset-"hellounset"}" $LINENO $FUNCNAME
    local nullvar
    dbgecho "default value (null): ${nullvar:-`whoami`}" $LINENO $FUNCNAME  ## it can be used to check parameter
                                                                            ## it you want to assign at the same time
                                                                            ## use '=' or ':=' instead
    : ${notset:="helloset"}     ## the appearance of ':' is important
    dbgecho "default value (unset, assigned): $notset" $LINENO $FUNCNAME

    local arr=( "ab" "abcd" "abcde" )
    dbgecho "length of the array: ${#arr[*]}" $LINENO $FUNCNAME
    dbgecho "length of the first item of the array: ${#arr}" $LINENO $FUNCNAME

    local var=point
    local point="in-direct-value"
    dbgecho "in-direct reference: $( eval echo \$$var )" $LINENO $FUNCNAME
    dbgecho "in-direct reference: ${!var}" $LINENO $FUNCNAME

    (( likeC=1<3?11:22 ))   ## only apply to algorith
    dbgecho "like C style: $likeC" $LINENO $FUNCNAME

    ## A comment trick: 
    ## : "
    ## This is 
    ## a multiline
    ## comments :)
    ## "

    for a; do   ## by default, the list is #@
        dbgecho "$a " $LINENO $FUNCNAME
    done

}


test_op() {
    dbgecho "pwd: $PWD" $LINENO $FUNCNAME
    op="ls"
    $op > "tmp.txt"
}


##### Snippet #######

## echo *.txt != echo "*.txt"

test_algorithm
test_local
test_brace_redirection
test_background_loop
test_boolean_and_parameter "para 1" "para 2"
test_loop
test_string "a" "b" "c" "d" "e"
## test_op
