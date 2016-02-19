#!/bin/bash
# this script saves all changed and new files to github 
# add the files which have changed or been added or 
# deleted to our file list
git add -A
# commit our changes, using the command line arguments 
# as our commit comment
git commit -m "$1"
# push the committed changes to github
git push
