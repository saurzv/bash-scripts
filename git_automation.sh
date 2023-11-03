#! /bin/bash

# emoji unicode
arrow='\U27A4'

# store user answers in this variable
ans=''

# change the directory to the calling directory
cd "$(pwd)"

function checkInit(){
    if [ -d .git ]; then
        printf "${arrow}  Already a git directory... All good!\n"
    else
        initGit
    fi
    return 0
}

function initGit(){
    printf "${arrow}  Not a git repository...\n"
    printf "${arrow}  Run 'git init'? [Y/n]: "
    read ans
    parseAns
    if [[ $? == 0 ]]; then
        git init
    else
        printf "${arrow}  Abort...\n"
    fi
    return 0
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

function serveMenu(){ 
    echo
}

checkInit
