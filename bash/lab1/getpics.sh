#!/bin/bash
# this script creates a Pictures directory and puts
#   some image files into it, unless they are there 
#   already
[ -d ~/Pictures ] || mkdir ~/Pictures
 cd ~/Pictures
 [ -e pics.zip ] || wget -nv http://zonzorp.net/pics.zip &&
   unzip pics.zip &&
   rm pics.zip

