#! /bin/bash

. util.sh

## dbgecho() 
## {
##     ## printf "#%-30s @%-8s --- $1\n" $3 $2
##     ## echo "#$3, @line:$2 --- $1"
##     a=$( caller 0 )
##     OldIFS="$IFS"
##     IFS=" "
##     arr=( $a )
##     IFS="$OldIFS"
##     local line=${arr[0]}
##     local func=${arr[1]}
##     printf "#%-30s @%-8s --- $1\n" $func $line
## }

test_local()
{
    local a
    a=12345
    dbgecho "local a: $a"
}

test_background_loop() 
{
    for i in "a" "b" "c"; do
        dbgecho "background loop: $i"
    done &

    ##wait      --- let's see the difference between comment or uncomment it

    ## if come across the annoying problem in which you have to type ENTER
    ## try appending 'wait' command at the end of the script :)
}

test_brace_redirection() 
{
    local l1
    local l2
    local l3
    local file="$HOME/braces.txt"
    {
        echo "hello"
        echo "world"
        echo "haha between braces"
    }>$file
    dbgecho "write ok"
    {
        read l1 ## should not write as read $l1
        read l2
        read l3
    }<$file
    dbgecho "$l1, $l2, $l3"
    ## it also works like below: 
    while read temp; do
        dbgecho "in while read: $temp"
    done<$file

    rm -f $file
    
    {
        dbgecho "hello world"
    } | tr "l" "k"
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
        dbgecho "$file exists" 
    fi

    if [ "$file" = "/bin/vi" ]; then
        dbgecho "two virables equal" 
    fi

    ## clause between {} is called 'anonymous function'
    [ -f "$file" ] && dbgecho "$file exists" || \
        { dbgecho "$file does not exists"; exit 1; } 

    [[ -n "$1" ]] && dbgecho "\$1 is defined: $1" || \
        dbgecho "\$1 is not defined"
    [ -n "$2" ] && dbgecho "\$2 is defined: $2" || \
        dbgecho "\$2 is not defined"

    local nArgs=$#
    dbgecho "number of args: $nArgs"
    local lastArg=${!nArgs}    # ${!#} is prefered :)
    dbgecho "last arg: $lastArg"

    local enter="/root/"
    if cd $enter 2> /dev/null; then
        dbgecho "enter new dir"
        for item in $enter/*; do    ## take a look at the usage: $enter/*
            dbgecho "item: $item"
        done
    else
        dbgecho "entering dir fails"
    fi


}

test_loop() 
{
    zipFile="/root/test.tar.gz"
    if [ -f $zipFile ]; then 
        case $( file $zipFile ) in 
            *"Zip archive"* )
                dbgecho "zip archive";;
            *"gzip compressed"* )
                dbgecho "gzip archive";;
            *"bzip2 compressed"* ) 
                dbgecho "bzip2 archive";;
            * ) 
                dbgecho "undef";;
        esac
    else 
        dbgecho "$zipFile does not exists"
    fi

    ## {1..3} can be replaced by "1" "2" "3"
    for i in {1..3}; do 
    dbgecho "$i"
    done

    for (( i=0;i<3;i++ )); do
        dbgecho "$i"
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
    dbgecho $(( 2#101010 ))

    ## ',' links a series of math op, last op is returned
    dbgecho $(( 1+2,2+3 ))
}

test_string() 
{
    local str="hello world"
    dbgecho "length of str: ${#str}"

    dbgecho "substr to end: ${str:6}"
    dbgecho "slice substr: ${str:6:3}"    ## the same as: echo | awk '{printf substr("'"$str"'", 3, 4) "\n"}'
                                          ## take note: echo is used to generate a fake input so as not to offer a file to awk
                                          ## take note: "'"$str"'"
    dbgecho "substr from backend: ${str:(-6)}"
    dbgecho "subtract paras to the end (*): ${*:3}"  
    ## dbgecho "subtract para (@): ${@:3}"  ## look at the difference in the stdout :) 
    dbgecho "subtract paras like slice: ${*:3:2}"  
    dbgecho "cut str from left (not greedy): ${str#h*l}"  
    dbgecho "cut str from left (greedy): ${str##h*l}"  
    dbgecho "cut str from right (not greedy): ${str%l*}"  
    dbgecho "cut str from right (greedy): ${str%%l*}"  
    dbgecho "replace str once: ${str/l/o}"  
    dbgecho "replace str all: ${str//l/o}"  
    dbgecho "replace str from head: ${str/#he/she}"  
    dbgecho "replace str from end: ${str/%ld/lllllld}"  
    dbgecho "default value (unset): ${unset-"hellounset"}"
    local nullvar
    dbgecho "default value (null): ${nullvar:-`whoami`}"  ## it can be used to check parameter
                                                          ## it you want to assign at the same time
                                                          ## use '=' or ':=' instead
    : ${notset:="helloset"}     ## the appearance of ':' is important
    dbgecho "default value (unset, assigned): $notset"

    local arr=( "ab" "abcd" "abcde" )
    dbgecho "length of the array: ${#arr[*]}"
    dbgecho "length of the first item of the array: ${#arr}"

    local var=point
    local point="in-direct-value"
    dbgecho "in-direct reference: $( eval echo \$$var )"
    dbgecho "in-direct reference: ${!var}"

    (( likeC=1<3?11:22 ))   ## only apply to algorith
    dbgecho "like C style: $likeC"

    ## A comment trick: 
    ## : "
    ## This is 
    ## a multiline
    ## comments :)
    ## "

    for a; do   ## by default, the list is #@
        dbgecho "$a "
    done

}


test_op() 
{
    dbgecho "pwd: $PWD"
    op="ls"
    $op > "tmp.txt"
}

test_ifs() 
{
    OIFS="$IFS" ## i think it is necessary to quote $IFS.
                ## but it is also right not to quote :)
    IFS=:
    while read line; do
        arr=( $line )   ## See $line is like a Micro, 
                        ## so it can be constructed
                        ## into an Array
        dbgecho "${arr[0]} uses ${arr[6]} (shell)"
    done<"/etc/passwd"
    IFS="$OIFS"
}



##### Snippet #######

## 'echo *.txt' is not the same as 'echo "*.txt"'

test_algorithm
test_local
test_brace_redirection
## test_background_loop
## test_boolean_and_parameter "para 1" "para 2"
## test_loop
## test_string "a" "b" "c" "d" "e"
## test_ifs
## test_op
