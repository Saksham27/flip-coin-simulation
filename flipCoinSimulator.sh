#!/bin/bash -x

# constants
HEADS=1 # TAILS wil be 0
NO_OF_SIMULATIONS=10

# declaring dictionary
declare -A singletData
declare -A doubletData
declare -A tripletData

# declaring array
declare -a singletArray
declare -a doubletArray
declare -a tripletArray

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
singletArrLen=0
doubletArrLen=0
tripletArrLen=0

singletWinningComb=0
doubletWinningComb=0
tripletWinningComb=0

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
# param1 : element whose percentage you want
function percentage() {
	echo "scale=2; ($1/$NO_OF_SIMULATIONS)*100" | bc
}

# fucntion to sort the results in descending order
# param 1 : array which you want to sort
function sortDescending() {

	# local constant
	TRUE=1

	# local variables
	local tempArray=("$@")

	for (( i=0; i<$(( ${#tempArray[@]}-1 )); i++ ))
	do
		for (( j=0; j<$(( ${#tempArray[@]}-1-$i )); j++ ))
		do
			if [ $(echo "${tempArray[$j]} <= ${tempArray[$j+1]}" | bc -l) -eq $TRUE ]
			then
				temp=${tempArray[$j]}
				tempArray[$j]=${tempArray[$j+1]}
				tempArray[$j+1]=$temp
			fi
		done
	done

	echo ${tempArray[@]}
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

for var in ${!singletData[@]} # storing in array to sort
do
	singletArray[$singletArrLen]=${singletData[$var]}
done

singletArray=$( sortDescending ${singletArray[@]} ) # sorting the array

for var in ${!singletData[@]}
do
	if [ ${singletArray[0]} = ${singletData[$var]} ] # getting the Winning combination
	then
		 singletWinningcomb=$var
		break
	fi
done

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
THPercentage=$( percentage $THCount ) # doublet TailHead percentage
TTPercentage=$( percentage $TTCount ) # doublet TailTail percentage

for var in ${!doubletData[@]} # storing in array to sort
do
	doubletArray[$doubletArrLen]=${doubletData[$var]}
done

doubletArray=$( sortDescending ${doubletArray[@]} ) # sorting the array

for var in ${!doubletData[@]}
do
	if [ ${doubletArray[0]} = ${doubletData[$var]} ] # getting the Winning combination
	then
		 doubletWinningcomb=$var
		break
	fi
done

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

for var in ${!tripletData[@]} # storing in array to sort
do
	tripletArray[$tripletArrLen]=${tripletData[$var]}
done

tripletArray=$( sortDescending ${tripletArray[@]} ) # sorting the array

for var in ${!tripletData[@]}
do
	if [ ${tripletArray[0]} = ${tripletData[$var]} ] # getting the Winning combination
	then
		 tripletWinningcomb=$var
		break
	fi
done
