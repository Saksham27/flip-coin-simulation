#!/bin/bash -x

# constants
HEADS=1
TAILS=0

# function to flip coin
function flipCoin() {
	local coin=$((RANDOM%2))
	if [ $coin -eq $HEADS ]
	then
		echo "heads"
	else
		echo "tails"
	fi
}

# simulating one coin flip
flipCoin
