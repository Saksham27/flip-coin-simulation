#!/bin/bash -x

# constants
HEADS=1 # TAILS wil be 0
NO_OF_SIMULATIONS=10

# declaring dictionary
declare -A singletData
declare -A doubletData
declare -A tripletData

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
HHHCount=0
HHTCount=0
HTHCount=0
HTTCount=0
THHCount=0
THTCount=0
TTHCount=0
TTTCount=0
HHHPercentage=0
HHTPercentage=0
HTHPercentage=0
HTTPercentage=0
THHPercentage=0
THTPercentage=0
TTHPercentage=0
TTTPercentage=0

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

# fucntion to calculate percentage
function percentage() {
	echo "scale=2; ($1/$NO_OF_SIMULATIONS)*100" | bc
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

HPercentage=$( percentage $HCount ) # singlet Head percentage
TPercentage=$( percentage $TCount ) # singlet Tail percentage

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

HHPercentage=$( percentage $HHCount ) # doublet HeadHead percentage
HTPercentage=$( percentage $HTCount ) # doublet HeadTail percentage
HTPercentage=$( percentage $THCount ) # doublet TailHead percentage
HTPercentage=$( percentage $TTCount ) # doublet TailTail percentage

# simulating triplet coin flip
for (( i=1; i<=$NO_OF_SIMULATIONS; i++ ))
do
	temp1=$( flipCoin )
	temp2=$( flipCoin )
	temp3=$( flipCoin )
	(( "$temp1""$temp2""$temp3"Count++ ))
	if  [ tripletData["$temp1""$temp2""$temp3"] ]
	then
		(( tripletData["$temp1""$temp2""$temp3"]++ ))
	else
		tripletData["$temp1""$temp2""$temp3"]=1
	fi
done

HHHPercentage=$( percentage $HHHCount ) # triplet HeadHeadHead percentage
HHTPercentage=$( percentage $HHTCount ) # triplet HeadHeadTail percentage
HTHPercentage=$( percentage $HTHCount ) # triplet HeadTailHead percentage
HTTPercentage=$( percentage $HTTCount ) # triplet HeadTailTail percentage
THHPercentage=$( percentage $THHCount ) # triplet TailHeadHead percentage
THTPercentage=$( percentage $THTCount ) # triplet TailHeadTail percentage
TTHPercentage=$( percentage $TTHCount ) # triplet TailTailHead percentage
TTTPercentage=$( percentage $TTTCount ) # triplet TailTailTail percentage

