#!/bin/bash

git -C $1 rev-parse --abbrev-ref HEAD  2> /dev/null
# function print_message
# {
#     git rev-parse --abbrev-ref HEAD  2> /dev/null
# }
# 
# print_message
