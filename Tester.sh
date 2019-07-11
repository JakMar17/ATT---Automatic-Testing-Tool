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
E_EXPLAMATION='\U2755'
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
times=false
timeout=1
warnings=false
emojiEnabled=true
language="java" #supported languages at this point: Java {default, java}, C {c}, C++ {cpp}

#functions

function help() {
    echo TO-DO
    exit 39
}

#checking if language is supported
function supported_language() {
    if [ $1 == "java" ]; then
        printf "%b  %s\n" $E_QUESTION "Testing: "$program".java"
        return 0
    elif [ $1 == "c" ]; then
        printf "%b  %s\n" $E_QUESTION "Testing: "$program".c"
        return 0
    elif [ $1 == "cpp" ]; then
        printf "%b  %s\n" $E_QUESTION "Testing: "$program".c"
        return 0
    else
        echo Language not supported {supported: java, c, cpp}
        exit 41
    fi
}

#comparing two files and printing result
#example compare $fileToCompare1 $fileToCompare2 $output file
function compare() {
    diff --ignore-trailing-space $1 $2 > $3 2> $3
    
    errorStatus=$?
    if [ $errorStatus -eq 2 ]; then
        return 2
    fi

    return 0
}

#printing result of one of the test cases
#example printResult $fileName
function printResult() {
    fileName=$1
    diffFile=$diffOutput"/"$fileName
    exitStatus=$2
    duration=$3

    if [ $exitStatus -ne 0 ]; then
        printf "${BLUE}%b${NC}  %s\t ${BLUE} Error: diff returned %d, ignoring${NC}\n" $E_EXPLAMATION $fileName $exitStatus
        (( noOfTest-- ))
    elif [ -s $diffFile ]; then
        printf "${RED}%b${NC}  %s\t ${RED}NOK${NC}" $E_XMARK $fileName
    else
        printf "${GREEN}%b${NC}  %s\t ${GREEN}OK ${NC}" $E_CHECKMARK $fileName
        (( okCases++ ))
    fi

    if [ $times == "true" ]; then
        printf " (%d ms)\n" $duration
    else
        printf "\n"
    fi

    (( noOfTests++ ))
}

#delete all emojis if those are disabled
function emojis() {
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

function javaCompile() {
    if javac $program".java" 2> $programOutput"/error.txt"; then
        printf "%b  %s\n\n" $E_CHECKMARK "Compiling: OK"
        rm $programOutput"/error.txt"
    else
        printf "${ORANGE}Compiling failed\n${NC}Exiting\n"  
        exit 40
    fi
}

function cCompile() {
    #compile program using gcc
    if gcc "./"$program".c" -o $program 2> $programOutput"/error.txt"; then
        if [ -s $programOutput"/error.txt" ]; then
            printf "${BLUE}%s\n${NC}" "Compiled with warnings"
            if [ $warnings == true ]; then
                :
            else
                printf "To continue testing with warnings use '-w true' while running script\n"
                printf "Exiting\n"
                exit 38
            fi
        else
            printf "%b  %s\n\n" $E_CHECKMARK "Compiling: OK"
            rm $programOutput"/error.txt"
        fi
    else
        printf "${ORANGE}Compiling failed\n${NC}Exiting\n"  
        exit 40
    fi
}

#function for compiling file
#if programming language takes a lot of code to be compiled make new function called xxCompile
function compile() {
    case $language in
        "java")
            javaCompile
        ;;
        "c")
            cCompile
        ;;
        *)
            exit 40
            ;;
    esac
}

#function for running file
#if programming language takes a lot of code to be compiled make new function called xxRun
function run() {
    file=$1

    case $language in
        "java")
            start=$(date +%s%N)
            timeout $timeout java $program < $file > $programOutput"/"$fileName
            exitStatus=$?
            finnish=$(date +%s%N)
        ;;
        "c")
            timeout $timeout "./"$program < $file > $programOutput"/"$fileName
            exitStatus=$?
        ;;
        *)
            exit 40
            ;;
    esac
    return $exitStatus
}

function testing() {
    #compile code
    compile

    for file in $input"/"*.txt; do
        fileName=$(basename -- "$file")

        #running
        start=$(date +%s%N)
        run $file
        exitStatus=$?
        
        finnish=$(date +%s%N)
        duration=$(( finnish-start ))
        duration=$(($duration/1000000))

        #if timeout
        if [[ $exitStatus == 124 ]]; then
            printf "%b  %s\t${BLUE}Timeout${NC}\n" $E_TIMEOUT $fileName
            continue
        fi
        
        #comparing
        compare $testCases"/"$fileName $programOutput"/"$fileName $diffOutput"/"$fileName
        exitStatus=$?
        #printing
        printResult $fileName $exitStatus $duration

    done

}

function result() {
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

#main script

if [ $# -lt 1 ]; then
    echo "Error: at least 1 argument"
    exit 42
elif [ $1 == "help" ]; then
    help
else
    program=$1
    echo $program
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
    elif [ $argument == "-w" ]; then
        (( i++ ))
        warnings=${!i}
    elif [ $argument == "-t" ]; then
        (( i++ ))
        timeout=${!i}
    elif [ $argument == "-times" ]; then
        times=true
    fi
done

emojis
supported_language $language

rm -rf $output
mkdir -p $output
mkdir -p $output"/programOutput"
mkdir -p $output"/diff"

testing
result

exit 0