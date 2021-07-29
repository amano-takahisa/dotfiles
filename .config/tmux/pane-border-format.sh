#!/bin/bash

CHAR_BRANCH=$'\uE725'
branch_name="$(git -C $1 rev-parse --abbrev-ref HEAD  2> /dev/null)"
git_root_path="$(git -C $1 root  2> /dev/null)"
[[ "$git_root_path" =~ .+/([^/]+)$ ]]
git_root_name="${BASH_REMATCH[1]}"
if [ -n "$branch_name" ] ; then
    echo $CHAR_BRANCH $branch_name@$git_root_name' '
fi
