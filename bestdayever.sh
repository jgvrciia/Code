#!/bin/bash


NAME=$1
COMPLIMENT=$2
USER=$(whoami)
DATE=$(date)
WHEREAMI=$(pwd)

echo "Goodmorning $NAME!!"

sleep 1

echo "You're looking good today $NAME!!!"

sleep 1

echo "You have the best $COMPLIMENT I've ever seen $NAME!!!"

sleep 2

echo "You are currently logged in as $USER and you're in directory $WHEREAMI. Also today is $DATE "
