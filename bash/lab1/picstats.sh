#!/bin/bash
# this script displays how many files are in ~/Pictures,
#    how much space they use, and the sizes and names of 
#    the 3 largest files

echo -n There are `find ~/Pictures -type f | wc -l` echo " files in the ~/Pictures directory"

# from joseph holland
echo -n "There are " 
find ~/Pictures -type f | wc -l | xargs echo -n 
echo " files in the ~/Pictures directory" 

echo "The Pictures directory uses:" 
du -sh ~/Pictures 

echo "The 3 largest files in the ~/Pictures directory are:"

# from Michael - du -h ~/Pictures/* | sort -hr | head 
# -n3 from Simon - ls -lnhS ~/Pictures | grep ^- | head  -3

cd ~/Pictures
find . -type f -exec du -h {} \; | sort -h | tail -3
