#!/bin/bash
#
# this script asks the user for a number and uses
#     that to dereference a colour which it then uses to 
# find an animal Variables
###########
colours=("red" "green" "blue")
 declare -A animals 
animals=([red]="cardinal" [green]="frog" [blue]="lobster")
# Main
######
read -p "Give me a number from 0-2: " num
 echo "index $num in colours has ${colours[$num]} in it" 
animalkey="${colours[$num]}"
echo "the corresponding animal is a ${animals[$animalkey]}"
