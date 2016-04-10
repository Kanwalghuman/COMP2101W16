#!/bin/bash

#Harkanwaljit Singh
#Student# 200307359

# this script gets 2 numbers from the user
#   a count of dice and a count of sides per die it prints out the results of rolling those dice Variables
###########
# the number of dice will be kept in $count, defaulting to 2 the number of sides to a die will be kept in $sides, defaulting to 6 start the total rolled at zero

sum=0

#Help function 
#Client can use this function to get help about this Script

help_function() {
	
	cat <<-EOF
		        Script will roll a dice 
                To get a random value 
                And give sum of of values as a output
                
                Option Arguments
                
                -d for count of dice, must be between 1-5
                -s for number of sides of a dice, between 4-20 

                Example:
                ./filename -d 4 # this command specify number of dices are 4
                ./filename -s 4 # number of sides will be 4
	EOF
}
# Main
######
# Process the command line, checking for count and sides

while [ $# -gt 0 ]; do
    case "$1" in
    -h | --help )  # to execute help function
            help_function
            exit 0
            ;;
    -d )  # -d option is for dice 
        if [[ "$2" =~ ^[1-5]$ ]]; then
            dices=$2
            shift
        else
            echo "I wanted a number after the -c, from 1 to 5. CYA Bozo!"
            exit 2
        fi
        ;;
    -s ) # -s option is for sides 
        if [[ "$2" =~ ^[1-9][0-9]*$ ]]; then
            if [ "$2" -ge 4 -a "$2" -le 20 ]; then
                sides=$2
                shift
            else
                echo "I wanted a number after the -s, from 4 to 20. CYA Bozo!"
                exit 2
            fi
        fi
       ;;
       
    * )
        echo "type -h or --help to get help"
        exit 1
       ;;
     
    esac
    shift
done 

if [ -z "$dices" ]; then
    # ask the user how many dice they want to roll
    read -p "How many dice[1-5, default is 2]? " numdice

    # use what they gave us if it is a number from 1-5
    if [[ "$numdice" =~ ^[1-5]$ ]]; then
        dices=$numdice
    else
        dices=2
        echo "Using a default of 2 since you aren't very helpful."
    fi 
fi 

if [ -z "$sides" ]; then
    # ask the user how many sides these dice have
    read -p "How many sides[4-20, default is 6]? " numsides

    # use what they gave us if it is a number from 4-20
    if [[ "$numsides" =~ ^[1-9][0-9]*$ ]]; then
        if [ $numsides -ge 4 -a $numsides -le 20 ]; then
            sides=$numsides
        else
            sides=6
            echo "Using 6-sided dice, since you are being difficult"
        fi
    else
        sides=6
        echo "Using 6-sided dice, since you are being difficult"
    fi 
fi

# loop through the dice, rolling them and summing the rolls
while [ $dices -gt 0 ]; do

    # the roll range is based on the number of sides
    roll=$(( $RANDOM % $sides +1 ))
    
    # add the current roll total to the running total
    sum=$(( $sum + $roll ))
    
    # give the user feedback about the current roll
    echo "Rolled $roll"
    
    # the loop will end when the count of dice to roll reaches zero
    ((dices--)) 
    done
# done rolling, display the sum of the rolls
echo "You rolled a total of $sum"