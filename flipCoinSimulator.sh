#!/bin/bash -x

# constants
HEADS=1 # TAILS wil be 0
NO_OF_SIMULATIONS=10

# declaring dictionary
declare -A data

# declaring array
declare -A percentage



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


#function to simulate singlet, doublet or triplate coin flip
# param1 : singlet, doublet or triplet

function multipleCoinFlip() {
	local maxVal=0
	local tempCount=0
	for (( i=1; i<=$NO_OF_SIMULATIONS; i++ ))
	do
		local face=''
		case $1 in
			"singlet")
				tempCount=1
				;;
			"doublet")
				tempCount=2
				;;
			"triplet")
				tempCount=3
				;;
		esac

		for (( j=1; j<=$tempCount; j++ ))
		do
			face+=$(flipCoin)
		done

		if  [ data[$face] ]
   	then
     		(( data[$face]++ ))
		else
      	data[$face]=1
		fi

		Percentage[$face]=$( percentage "${data[$face]}" )

		if [ $maxVal -le ${data[$face]} ]
		then
			maxVal=${data[$face]}
			winningComb=$face
		fi
	done

	echo $winningComb
}



echo "Winning combination in singlet : " $( multipleCoinFlip "singlet" )
echo "Winning combination in doublet : " $( multipleCoinFlip "doublet" )
echo "Winning combination in triplet : " $( multipleCoinFlip "triplet" )

