#!/bin/bash
# rolldice.sh

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




#error message
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




#pictstat.sh

#!/bin/bash

#Harkanwaljit Singh
#Student# 200307359

# this script displays how many files are in ~/Directory,
#    how much space they use, and the sizes and names of the number of largest files

#default directory
dir=~/Pictures

#defult number
temp=3



#help function for the client 
help_function() {
	
	cat <<-EOF
		        Script will count the pictures in Directory
		        And size of the Directory 
		        also print name and size of number of largest files in the directory
                
                Option Arguments
                
                -c and --count  to count the Number of files 
                 
                Example:
                ./filename -c 4 lib # print the 4 largest Pictures in lib directory
	EOF
}



#error message 
error-message () {
	
	echo "error message $filename: $1 " >&2

	
}

while [ $# -gt 0 ]; do
    case "$1" in
    -h | --help )  # to execute help function
            help_function
            exit 0
            ;;
    -c | --count )
            
            temp=$2
            shift
            
            ;;
    * )
            
            dir=~/$1
        ;;
    esac
    shift
done 


# command to count the number of files in a directory
            number=$( find $dir -type f | wc -l)
            echo "Number of Pictures in $dir are $number"

if [ $number -gt 0 ]; then

    echo "The $dir directory uses:"
    du -sh $dir   # command to calculate the size of the directory
    echo "The $temp largest Pictures in the ~/$dir directory are:"
    cd $dir
    # command to find 3 largest files in the directory
    find . -type f -exec du -h {} \; | sort -h | tail -$temp

else

    error-message " Wrong Arguments"
    echo "type -h or --help to get help"

fi




#showinterface

#!/bin/bash

#Harkanwaljit Singh
#Student# 200307359Bas

# this script enumerates our 2 interfaces and
#   displays their configured IPV4 addresses as well as 
# default route information Variables
###########
defaultroute=0 # default is to not show the default route 

declare -A ip # hash of ip addresses keyed on interface name 

declare -a int # array of interface names supplied on the command line 

declare -a interface # array of discovered interface names


help_function() {
	
	cat <<-EOF
	        This Scipt will print the IPv4 addresses 
	        acoording to the given arguments 
	        If interface name not given script will print info of all interfaces
	        
	        optional arguments 
	        
	        ./filename -r or --route    # This will print default route
		    ./filename interfacename    # this will print the IP address of given interface
	EOF
	
}


error-message () {
	
	echo "error message $filename: $1 " >&2
	echo "use -h or --help option to get help"

	
}
# Main
######

# check the command line for an interface name or names, and 
# -r|--route

while [ $# -gt 0 ]; do
    case "$1" in
    -h| --help )
        help_function
        exit 0
        ;;
        
    -r|--route )
        defaultroute=1 # set showroute to a 1 if asked to display default route
        shift
        
        ;;
        
    *)
        if [ $? -eq 0 ]; then
        
                int+=("$1") # add unnamed parameters as interface names
        else 
                exit 1
        fi
                
    ;;
        
    esac
    shift 
done

# Get an array of our interface names, we will have at least  2
interface=(`ifconfig |grep '^[A-Za-z]'|awk '{print $1}'`)

# For each interface in the array, get the IP address and
#    save it to an array for IP addresses
for intf in ${interface[@]}; do
    ip[$intf]=`ifconfig $intf|grep "inet "|sed -e 's/.*inet addr://' -e 's/ .*//'` 
done

# Get default route gateway IP from the route command
gwip=`route -n|grep '^0.0.0.0'|awk '{print $2}'`

# Display the information we have gathered as requested
if [ ${#int[@]} -gt 0 ]; then # use specified interface list if we have one
    for intf in ${int[@]}; do # iterate over interface names requested
        if [ ${ip[$intf]} ]; then # only display info for an interface if we have some
            echo "$intf has address ${ip[$intf]}"
        else # for invalid interface names or interfaces with no address, just let the user know about it
            error-message "$intf is not an interface on this host or has no ip address assigned"
        fi
    done 
else
    for intf in ${interface[@]}; do # if no interfaces specified, display them all
        echo "$intf has address ${ip[$intf]}"
    done 
fi

# display the default route gateway if we were given -r or 
# --route on the command line
[ $defaultroute -eq 1 ] && echo "The default route is through $gwip"



#countdown.sh

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
    
    