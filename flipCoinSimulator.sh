#!/bin/bash -x

# constants
HEADS=1 # TAILS wil be 0
NO_OF_SIMULATIONS=10

# declaring a dictionary
declare -A singletData

# variables
HCount=0
TCount=0
HPercentage=0
TPercentage=0

# function to flip coin
function flipCoin() {
	local coin=$((RANDOM%2))
	if [ $coin -eq $HEADS ]
	then
		echo "H"
	else
		echo "T"
	fi
}

# simulating singlet coin flip
for (( i=1; i<=$NO_OF_SIMULATIONS; i++ ))
do
	temp=$( flipCoin )
	(( "$temp"Count++ ))
	if  [ singletData[$temp] ]
	then
		(( singletData[$temp]++ ))
	else
		singletData[$temp]=1
	fi
done

HPercentage=`echo "scale=2; ($HCount/$NO_OF_SIMULATIONS)*100" | bc` # singlet Head percentage
TPercentage=`echo "scale=2; ($TCount/$NO_OF_SIMULATIONS)*100" | bc` # singlet Tail percentage
