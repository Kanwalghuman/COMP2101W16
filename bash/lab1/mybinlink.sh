#!/bin/bash
# this script creates the link from ~/bin to my 
# ~/workspace/COMP2101W16/bash it will not disturb any 
# existing ~/bin filesystem entity
[ -e ~/bin ] || ln -s workspace/COMP2101W16/bash ~/bin
