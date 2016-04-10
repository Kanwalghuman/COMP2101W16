#!/bin/bash

#Harkanwaljit Singh
#Student# 200307359

# This script have a error fuction which sents arguments 
# from command line and  send that that to STDERR

#error function 
#funtion to sent argument to STDERR

error-message () {
	
	echo "error message $filename: $1 " >&2

	
}


#Main 
#This script will take argument from command line and send it to STDERR using error function 


while [ $# -gt 0 ]; do 
	
	error-message "$1" "1"
	shift
	
done