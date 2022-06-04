#!/bin/bash
#################################################################################################################
#
# Bash game based on video game called Elden Ring
#
#################################################################################################################
#
#
echo -e  "WELCOME TO ELDEN RING \n"
sleep 3
#
#
#
#
#
echo "Welcome Tarnished. Please select your starting class:
1 - Samurai
2 - Prisoner
3 - Prophet"
echo -e "\n"
#
read CLASS
#
case $CLASS in
#
	1)
		TYPE="Samurai"
		HP=10
		ATTACK=30
		;;
	2)
		TYPE="Prisoner"
		HP=20
		ATTACK=10
		;;
	3)
		TYPE="Prophet"
		HP=15
		ATTACK=20
		;;
esac
#
echo -e "\nYou've chosen the $TYPE class. Your HP is $HP and your attack is $ATTACK"
sleep 3
#
#
# First Beast Battle
#
BEAST=$(( $RANDOM % 2 ))
#
echo -e "\nThe First beast approaches. Prepare for battle. Pick a number between 0-1. (0/1) \n"
read TARNISHED
#
sleep 1
#
if [[ $BEAST == $TARNISHED || $TARNISHED == magic ]]; then
	echo -e "\nBeast VANQUISHED!! Congrats fellow tarnished"
else
	echo -e "\nYOU DIED"
	exit 1
fi
#
#
sleep 3
#
# Boss Battle
#
MARGIT=$(( $RANDOM % 10 ))
#
echo -e "\nMargit, The Fell Omen approaches. Prepare for boss battle. Pick a number between 0-9. (0-9) \n"
#
sleep 1
#
read TARNISHED
#
if [[ $MARGIT == $TARNISHED || $TARNISHED == "lord" ]]; then
	echo -e "\nEnemy Felled, you have defeated Margit, The Fell Omen"
elif [[ $USER == "root" ]];then
	echo -e "\nHey,root always wins!! you have defeated Margit, The Fell Omen"
else
	echo -e "\nYOU DIED"
fi
#
sleep 2
echo -e "\nThanks for playing \n"
sleep 3
#
# Game Credits
#
echo -e "CREDITS: \n"
sleep 3
echo -e "JUAN GARCIA \n"
sleep 2
echo "NetworkChuck "
#
#
exit
