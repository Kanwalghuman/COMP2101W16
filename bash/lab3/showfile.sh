#!/bin/bash
#
# this script shows the user the files in their 
# home directory,
#   lets them pick one using a menu, then 
# displays it using the more command 


# build an 
# array of files using the find command using a 
# non-printing character for the input field 
# separator allows us to handle special 
# characters in the filenames
savedFS="$IFS" 
IFS=$'\003'

# use the find command to find non-empty 
# regular files in the user's home directory
files=(`find "$HOME" -maxdepth 1 -type f -readable -size +0 -printf %P$'\x3'`)

# put the input field separator back to what it 
# was so other input commands work as expected
IFS="$savedFS"

# use a loop to ask for a choice so that we can 
# ask again if necessary
while [ 1 ]; do
    # display the files as a menu, with a 
    # number in front of each
    clear
    for (( count=1;count <= ${#files[@]};count++ )); do
        echo "$count) ${files[$(($count-1))]}"
    done
    
    # display a prompt, asking the user to pick 
    # a valid menu number
    read -p "Select a file [1-${#files[@]}] " filenum
    
    # make sure they gave us a number
    if [[ "$filenum" =~ ^[1-9][0-9]*$ ]]; then
        # make sure the number they gave us is 
        # valid
        if [ $filenum -ge 1 -a $filenum -le ${#files[@]} ]; then
            # use the "more" command to display 
            # the content of the file
            more "$HOME/${files[$(($filenum-1))]}"
            read -p "press enter to continue or control-c to end"
            continue # allow them to choose another file
        fi
    fi
    # if they didn't give us a valid number,
    #    let them know that they messed up and 
    #    go back through the loop
    read -p "That was not a valid choice, press enter to try again"
done
