#!/bin/bash

CHAR_BRANCH=$'\uE725'
branch_name="$(git -C $1 rev-parse --abbrev-ref HEAD  2> /dev/null)"
if [ -n "$branch_name" ] ; then
    echo $CHAR_BRANCH $branch_name' '
fi
