#!/bin/bash
# this script uses simulated dice to pick a food from
#     an array of 11 foods build an array of foods
foods=("apple" "banana" "cherry" "date" "elderberry" "fig" "grape" "ham" "ice cream" "jagdwurst" "kumquat")
# roll two dice and add them
die1=$(($RANDOM % 6 + 1))
 die2=$(($RANDOM % 6 + 1)) 
diceroll=$(($die1 + $die2))
# display the food from the foods array which has our 
# dice roll as the index
index=$(($diceroll -2))
echo "We chose a ${foods[$index]} because we rolled $die1,$die2 for a $diceroll"
