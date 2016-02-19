#!/bin/bash
# this script enumerates our 2 interfaces and
#   displays their configured IPV4 addresses as well as 
# default route information Get an array of our 
# interface names, we will have at least 2
interfaces=(`ifconfig |grep '^[A-Za-z]'|awk '{print $1}'`)

# this was for debugging purposes echo "Our interfaces 
#include ${interfaces[@]}"
# For the first interface in the array, get the IP 
# address and
#    save it to an array for IP addresses
ip[0]=`ifconfig ${interfaces[0]}|grep "inet "|sed -e 's/.*inet addr://' -e 's/ .*//'`

# For the second interface in the array, get the IP 
# address and
#    save it to the array for IP addresses
ip[1]=`ifconfig ${interfaces[1]}|grep "inet "|sed -e 's/.*inet addr://' -e 's/ .*//'`

# Get default route gateway IP from the route command
gwip=`route -n|grep '^0.0.0.0'|awk '{print $2}'`

# Display the information we have gathered
echo "${interfaces[0]} has address ${ip[0]}" 
echo "${interfaces[1]} has address ${ip[1]}"
 echo "Our default route is through $gwip"
