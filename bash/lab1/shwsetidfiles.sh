#!/bin/bash
# this script shows the set uid and gid files in /usr
echo "Setuid files in /usr" 
echo "====================" 
find /usr -perm -4000 -type f -ls 

cat <<EOF 

Setgid files in /usr ==================== 
EOF
find /usr -perm -2000 -type f -ls
