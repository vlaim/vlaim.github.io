#!/bin/bash

#ifdef __USAGE
#created by Helen Bogdanova
#December, 7 2014
#SYNTAX: helen [path]
#endif



# Terminates program if input date is incorrect

isDate(){	
	date "+%m/%d/%Y" -d "$2/$1/$3" 2>1 > /dev/null
	is_valid=$?
	
	if [ $is_valid -eq 1 ]
	then
		echo "Incorrect date. Program terminated!"
		exit 1
	fi
}


#if argument is not defined - use current path

path=$1

if test -z "$1"
then
	path=$(pwd)
fi


oldIFS="$IFS" #change IFS
IFS="-"

echo "Enter date (format dd-mm-yyyy)"
read d m y
isDate $d $m $y

touch -t "${y}${m}${d}0000" dstamp #create timestamp

echo "Enter filename (find.txt as default)"
read fn

if test -z "$fn"
then
	fn="find.txt"
fi

if test -f "$fn"
then
	echo "$fn exist. Overwrite it? All exist data will be erased y/[n]: "
	read yn
fi

# overwrite file:

if [ "$yn" = "y" ]
then
	rm "$fn"
fi

a=$(find $path -type f -newer dstamp -not -name dstamp -print | head -n 100) #exclude dstamp(!)
n=$(echo "$a" | wc -l) # number of files


#if empty - 0 files

if test -z "$a"
then
	n=0
fi


echo $a >> "$fn"
echo "---------------------------------" >> "$fn"
echo "$n file(s) found" >> "$fn"

rm dstamp #remove temporary

exit 0 
