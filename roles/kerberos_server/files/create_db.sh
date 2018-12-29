#!/bin/bash
echo -e "$1\n$1" | kdb5_util create -s -P "$2" 

# kdb5_util create -s -P hadoop


