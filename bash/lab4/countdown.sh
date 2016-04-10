#!/bin/bash

#Harkanwaljit Singh
#Student# 200307359

# This script demonstrates how to trap signals and handle them using functions

#### Functions


# The error-message function will send an error message to stderr
# Usage:
#   error-message ["some text to print to stderr"]
#error message 
error-message () {
	
	echo "error message $filename: $1 " >&2

	
}
#

# The usage function will display command syntax
help_function() {
	
	cat <<-EOF
	        This script will do countdown from specified number of seconds to 0
	        
            optiona argument 
            -i| --interval  number of seconds 
            
            exambple 
            ./countdown.sh -i 4
	
	EOF
}

#
sigint(){
    
     echo " Starting !!!!!!!!"   
}

sigquit() {
        
        logger -t 'basename "$0"' -i -p user.int -s 
        echo "ABORTING !!!!!!!!!!"
        exit 
}

#### Main Program

while [ $# -gt 0 ]; do
	case "$1" in
	-h|--help )
		userhelp # call fuction help for user
		exit 0
		;;
    -i| --interval)
            int=$2
       ;;
       
     *)
       errormessage "wrong argument"
       exit 2
    esac
done

for (( i=$int ; i >= 0 ; i-=$int )); do
        
        trap signit SIGINT
        
        trap sigquit SIGQUIT
        
done
    
    