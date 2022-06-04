#!/bin/sh 
#########################################################################################################
# Title			:run-scale-validation.sh
# Description	:Designed to run scale-validation.sh
# Author		:Juan Garcia
# Date			:05-19-2022
# Version		:0.1
#########################################################################################################
#
#
#
echo "making swqc-tmp"
#
mkdir swqc-tmp
echo "swqc-tmp created"
touch swqc-tmp/sim-check-remote-job-out.txt
#
IPSOURCE="ip.txt"
IPS=$(cat $IPSOURCE)
for IP in $IPS
do 
echo "Systems sim-check-remote-test.sh ran on $IP" >> swqc-tmp/sim-check-remote-job-out.txt
cat scale-validation.sh | sshpass -vp abcd1234 ssh -tt -oStrictHostKeyChecking=no root@$IP -yes
#
echo "ssh complete" > swqc-tmp/sshtest.txt
#
done
