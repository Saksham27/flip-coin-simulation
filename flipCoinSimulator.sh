#!/bin/bash -x

# constants
HEADS=1 # TAILS wil be 0
NO_OF_SIMULATIONS=10

# declaring dictionary
declare -A singletData
declare -A doubletData

# variables
HCount=0
TCount=0
HPercentage=0
TPercentage=0
HHCount=0
HTCount=0
THCount=0
TTCount=0
HHPercentage=0
HTPercentage=0
THPercentage=0
TTPercentage=0

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

# simulating doublet coin flip
for (( i=1; i<=$NO_OF_SIMULATIONS; i++ ))
do
	temp1=$( flipCoin )
	temp2=$( flipCoin )
	(( "$temp1""$temp2"Count++ ))
	if  [ doubletData["$temp1""$temp2"] ]
	then
		(( doubletData["$temp1""$temp2"]++ ))
	else
		doubletData["$temp1""$temp2"]=1
	fi
done

HHPercentage=`echo "scale=2; ($HHCount/$NO_OF_SIMULATIONS)*100" | bc` # doublet HeadHead percentage
HTPercentage=`echo "scale=2; ($HTCount/$NO_OF_SIMULATIONS)*100" | bc` # doublet HeadTail percentage
HTPercentage=`echo "scale=2; ($THCount/$NO_OF_SIMULATIONS)*100" | bc` # doublet TailHead percentage
HTPercentage=`echo "scale=2; ($TTCount/$NO_OF_SIMULATIONS)*100" | bc` # doublet TailTail percentage
