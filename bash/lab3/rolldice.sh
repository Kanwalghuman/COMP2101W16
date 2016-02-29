#!/bin/bash
# this script gets 2 numbers from the user
#   a count of dice and a count of sides per 
# die it prints out the results of rolling 
# those dice Variables
###########
count=2 # default of 2 dice 
sides=6 # default of 6 sides to a die 
sum=0 # start the total rolled at zero

# Main
######
# ask the user how many dice they want to roll
read -p "How many dice[1-5, default is 2]? " numdice 
[ -z "$numdice" ] && count=2

# use what they gave us if it is a number from 
# 1-5
if [[ "$numdice" =~ ^[1-5]$ ]]; then
    count=$numdice 
else
    echo "Count must be between 1 and 5"
    exit 2 
fi
# ask the user how many sides these dice have
read -p "How many sides[4-20, default is 6]? " numsides 

[ -z "$numsides" ] && sides=6
# use what they gave us if it is a number from 
# 4-20
if [[ "$numsides" =~ ^[1-9][0-9]*$ ]]; then
    if [ $numsides -ge 4 -a $numsides -le 20 ]; then
        sides=$numsides
    else
        echo "Number of sides per die must be between 4 and 20"
    fi 
else
    echo "Number of sides per die must be a number from 4 to 20" 
fi

# loop through the dice, rolling them and 
# summing the rolls
while [ $count -gt 0 ]; do

    # the roll range is based on the number of 
    # sides
    roll=$(( $RANDOM % $sides +1 ))
    
    # add the current roll total to the running 
    # total
    sum=$(( $sum + $roll ))
    
    # give the user feedback about the current 
    # roll
    echo "Rolled $roll"
    
    # the loop will end when the count of dice 
    # to roll reaches zero
    ((count--)) 
done

# done rolling, display the sum of the rolls
echo "You rolled a total of $sum"
