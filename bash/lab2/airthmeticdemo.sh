#!/bin/bash
# this script demonstrates arithmetic get two numbers 
# from the user to use
read -p "Give me a number " firstnum
 read -p "Give me another number " secondnum
# demo addition
sum=$(( $firstnum + $secondnum ))
 echo "$firstnum plus $secondnum equals $sum"


# demo subtraction
leftover=$(( $firstnum - $secondnum )) 
echo "$firstnum minus $secondnum equals $leftover"

# demo multiplication
product=$(( $firstnum * $secondnum ))
 echo "$firstnum multiplied by $secondnum equals $product"

# demo division
dividend=$(( $firstnum / $secondnum ))
 echo "$firstnum divided by $secondnum equals $dividend"

# demo modulus
rem=$(( $firstnum % $secondnum ))
echo "$firstnum divided by $secondnum leaves a remainder of $rem"
