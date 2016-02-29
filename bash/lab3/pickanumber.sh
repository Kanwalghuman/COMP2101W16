#!/bin/bash
# this script will ask the user for a random 
# number
#    between one and ten and will keep asking 
# until they get it right Variables
###########
# we need a random number for them to guess 
# between 1 and 10
myNumber=$(($RANDOM % 10 + 1))

# since our loop is controlled by their guess, 
# start with an incorrect guess
guess=0

# Main
######

# we aren't done until the user guesses our 
# number, so keep asking until they get it 
# right
while [ $guess -ne $myNumber ]; do
    # get a number from them
    read -p "Pick a number from 1 to 10: " guess
    
    while [[ ! "$guess" =~ ^[1-9]0*$ ]]; do
    # ask them over and over if they didn't 
    # give us something that looks like it 
    # might be valid
        read -p "Pick a number from 1 to 10: " guess
    done
    
    # give them feedback about their guess if 
    # it was wrong
    if [ $guess -lt $myNumber ]; then
        echo "Too small, try again"
    elif [ $guess -gt $myNumber ]; then
        echo "Too big, try again"
    fi
done
# loop ended, so they got it right, let them 
# know
echo "You got it!"
