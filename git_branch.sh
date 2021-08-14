#!/usr/bin/env bash

#!/bin/bash

function git_branches()
{
    if [[ -z "$1" ]]; then
        echo "Usage: $FUNCNAME <dir>" >&2
        return 1
    fi

    if [[ ! -d "$1" ]]; then
        echo "Invalid dir specified: '${1}'"
        return 1
    fi

    # Subshell so we don't end up in a different dir than where we started.
    (
    for d in $(find "$1" -maxdepth 2 -type d)
    do
     [[ -d "${d}/.git" ]] || continue
       if [[ "$2" == "all" ]]; then
         # search all local git branch, incase I checked out from branch I
         # am searching
         echo "$d [$(cd "$d"; git  branch )]"
       else
         echo "$d [$(cd "$d"; git  branch | grep '^\*' | cut -d' ' -f2)]"
       fi
     done
    )
}

git_branches "$@"
