#! /bin/bash

# use it for compiling and running cpp file
# take test cases from test_cases.txt by default

# color variables
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'

# store file name in this variable if passed
fileName=''
excutable=''

# store user answers
ans=''

function compile() {
    cat <<EOF

-----------------
----COMPILING----
-----------------

EOF
    if [[ ! $1 ]]; then
        echo -e "${RED}ERROR:\tNO FILE PASSED${NC}\n"
        exit 1
    else
        fileName=$1
        excutable=${fileName%.*}
        if [[ -e $excutable ]]; then
            echo -en "Excutable '$excutable' already exists, do you want to recompile '$fileName'? [Y/n]:\t"
            read ans
            parseAns
        fi
        if [ $? == 0 ]; then
            echo -e "\nrunning g++ $fileName -o $excutable\n"
            g++ $1 -o $excutable
            checkStatus
        else
            echo -en "\nRun excutable? [Y/n]:\t"
            read ans
            parseAns
            if [ $? == 1 ]; then
                echo -e '\nExiting...\n'
                exit 0
            fi
            run
        fi
    fi

    exit $?
}

function checkStatus() {
    if [ $? == 0 ]; then
        echo -e "${GREEN}COMPILATION SUCCESSFUL${NC}\n"
        run
    else
        echo -e "\n${RED}COMPILATION ERROR...${NC}\tEXITING NOW...\n"
    fi
    return $?
}

function run() {
    echo -en "\nTake input file? [Y/n]:\t"
    read ans
    parseAns
    if [ $? == 0 ]; then
        echo -e "\nRunning ./$excutable < test_cases.txt\n"
        ./$excutable <test_cases.txt
    else
        echo -e "\nRunning ./$excutable ...\n"
        ./$excutable
    fi
    return $?
}

function parseAns() {
    case $ans in
    'Y' | 'y' | '')
        return 0
        ;;
    *)
        return 1
        ;;
    esac
}

compile $1
