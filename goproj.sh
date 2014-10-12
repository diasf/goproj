#!/bin/bash

declare -A GOPROJECTS

# ------------------------------------------------------------------------
# the main goproj command
# ------------------------------------------------------------------------
function goproj() {
    VIM_OPT=false

    while getopts ":v" opt; do
        case $opt in
            v)
                VIM_OPT=true
                ;;
            \?)
                echo "Invalid option: -$OPTARG" >&2
                ;;
        esac
        shift $(($OPTIND-1))
    done

    cd ${GOPROJECTS[$1]}
    _setGOPATH

    if [ "$VIM_OPT" = true ]; then
        vim
    fi
}

# ------------------------------------------------------------------------
# autocomplition for the goproj command line
# ------------------------------------------------------------------------
_goproj() {
    cur=${COMP_WORDS[COMP_CWORD]}
    for project in "${!GOPROJECTS[@]}"
    do
        if [[ $project == $cur* ]]; then
            use="$use $project"
        fi
    done
    COMPREPLY=( $( compgen -W "$use" -- $cur ) )
}
complete -o default -o nospace -F _goproj goproj 

# ------------------------------------------------------------------------
# Sets the GOPATH variable to the directory above src, by going up the
# filesystem
# ------------------------------------------------------------------------
function _setGOPATH() {
    local originalPath=`pwd`
    local current=
    while true; do
        current=$(basename "$PWD")
        if [[ "$current" = "src" ]]; then
            cd ..
            echo "Setting GOPATH to: `pwd`"
            export GOPATH=`pwd`
            break
        elif [[ "$current" = "/" ]]; then
            echo "GOPATH not found"
            break
        fi
        cd ..
    done
    cd $originalPath
}
