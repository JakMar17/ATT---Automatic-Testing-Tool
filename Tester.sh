#!/bin/bash

#color variables
RED='\033[0;31m'
NC='\033[0m' #no color
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;36m'

#emojis
E_QUESTION='\U2754'
E_XMARK='\U2716'
E_CHECKMARK='\U2714'
E_TIMEOUT='\U231B'
E_BAD='\U1F44E' #0-49%
E_NOTGOOD='\U1F615' #50-59%
E_NEUTRAL='\U1F44D' #60-69%
E_GOOD='\U1F44C' #70-79%
E_EXCELENT='\U1F603' #80-89%
E_PERFECT='\U1F929' #90-99%

#paths to files
input="./input"
program=""
testCases="./testCases"

output="./output"
programOutput=$output"/programOutput"
diffOutput=$output"/diff"

#counters
noOfTests=0
okCases=0

#default cases
emojiEnabled=true
timeout="1s"
language="java" #supported languages at this point: Java {default, java}, C {c}, C++ {cpp}

#functions

function help() 
{
    echo TO-DO
    exit 39
}

#checking if language is supported
function supported_language() 
{
    if [ $1 == "java" ]; then
        printf "%b  %s\n" $E_QUESTION "Testing: "$program".java"
        return 0
    elif [ $1 == "c" ]; then
        return 0
    elif [ $1 == "cpp" ]; then
        return 0
    else
        echo Language not supported {supported: java, c, cpp}
        exit 41
    fi
}

#comparing two files
function compare()
{
    file1=$1
    file2=$2

    diff --ignore-trailing-space $file1 $file2 > $diffOutput"/"$fileName
}

#printing result of one of the test cases
function printResult()
{
    fileName=$1
    diffFile=$diffOutput"/"$fileName
    if [ -s $diffFile ]; then
        printf "${RED}%b${NC}  %s\t ${RED}NOK${NC}\n" $E_XMARK $fileName
    else
        printf "${GREEN}%b${NC}  %s\t ${GREEN}OK${NC}\n" $E_CHECKMARK $fileName
        (( okCases++ ))
    fi
    (( noOfTests++ ))
}

function emojis() 
{
    #delete all emojis if those are disabled
    if [ $emojiEnabled == false ]; then
        E_QUESTION=""
        E_XMARK=""
        E_CHECKMARK=""
        E_TIMEOUT=""
        E_BAD=""
        E_NOTGOOD=""
        E_NEUTRAL=""
        E_GOOD=""
        E_EXCELENT=""
        E_PERFECT=""
    fi
}

function javaTesting() 
{
    #compile Java code
    if javac $program".java" 2> $programOutput"/error.txt"; then
        printf "%b  %s\n\n" $E_CHECKMARK "Compiling: OK"
        rm $programOutput"/error.txt"
    else
        printf "${ORANGE}Compiling failed\n${NC}Exiting\n"
        exit 40
    fi

    #running & comparing
    for file in $input"/"*.txt; do
        fileName=$(basename -- "$file")

        #running
        timeout 1s java $program < $file > $programOutput"/"$fileName
        
        #if timeout
        if [[ $? == 124 ]]; then
            printf "%b  %s\t${BLUE}Timeout${NC}\n" $E_TIMEOUT $fileName
            continue
        fi
        
        #comparing
        compare $programOutput"/"$fileName $testCases"/"$fileName

        #printing
        printResult $fileName

    done
}

function cTesting()
{
    echo TO-DO
}

function result() 
{
    if [ $noOfTests -eq 0 ]; then
        return 0
    fi

    mark=$(($okCases*100/$noOfTests))
    printf "Result: %d/%d (%d%%) "  $okCases $noOfTests $mark
    
    if [ $mark -lt 50 ]; then
        printf "%b\n" $E_BAD
    elif [ $mark -lt 60 ]; then
        printf "%b\n" $E_NOTGOOD
    elif [ $mark -lt 70 ]; then
        printf "%b\n" $E_NEUTRAL
    elif [ $mark -lt 80 ]; then
        printf "%b\n" $E_GOOD
    elif [ $mark -lt 90 ]; then
        printf "%b\n" $E_EXCELENT
    elif [ $mark -lt 100 ]; then
        printf "%b\n" $E_PERFECT
    elif [ $mark -eq 100 ]; then
        printf "%b %b %b\n" $E_PERFECT $E_PERFECT $E_PERFECT
    fi

}

if [ $# -lt 1 ]; then
    echo "Error: at least 1 argument"
    exit 42
elif [ $1 == "help" ]; then
    help
else
    program=$1
fi

for (( i=2; i<="$#"; i++)); do
    argument=${!i}
    if [ $argument == "-l" ]; then
        (( i++ ))
        language=${!i}
    elif [ $argument == "-test" ]; then
        (( i++ ))
        testCases=${!i}
    elif [ $argument == "-o" ]; then
        (( i++ ))
        output=${!i}
        programOutput=$output"/programOutput"
        diffOutput=$output"/diff"
    elif [ $argument == "-i" ]; then
        (( i++ ))
        input=${!i}
    elif [ $argument == "-e" ]; then
        (( i++ ))
        emojiEnabled=${!i}
    fi
done

emojis
supported_language $language

rm -rf $output
mkdir -p $output
mkdir -p $output"/programOutput"
mkdir -p $output"/diff"

if [ $language == "java" ]; then
    javaTesting
elif [ $language == "c" ]; then
    cTesting
elif [ $language == "cpp" ]; then
    cTesting
fi
result

exit 0