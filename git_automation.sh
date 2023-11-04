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
        exit 1
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

function parseFlag(){
    checkInit
    if [ $# -gt 0 ]; then
        for arg in $@; do
            case $arg in
                'add-a')
                    # add modified files only
                    printf "${arrow}  Running 'git add -u'\n"
                    git add -u
                    ;;
                'add-u')
                    # add all untracked files
                    printf "${arrow}  Running "
                    echo -n 'echo -e "\na\n*\nq" | git add i'
                    echo
                    echo -e "\na\n*\nq" | git add -i
                    ;;
            esac
        done
    else
        printf "${arrow}  No arguments passed... Exiting\n"
        exit 1
    fi
    exit $?
}


parseFlag $@
