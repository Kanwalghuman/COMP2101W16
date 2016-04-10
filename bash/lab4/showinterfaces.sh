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
