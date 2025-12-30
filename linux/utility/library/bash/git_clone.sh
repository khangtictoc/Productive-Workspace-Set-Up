#! /bin/bash

function git_clone(){
    REPO="$1"
    DIR="$2"

    if [[ ! -d "$DIR" ]]; then
        git clone "$REPO" "$DIR"
    else
        echo "Directory exists — skipping clone"
    fi
}