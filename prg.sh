#!/bin/bash

#ifdef __USAGE
#created by Vladislav Alexeyev
#November, 24 2014
#SYNTAX: prg 
#endif

# Terminates program if input date is incorrect

function isDate
{
	# Other:
	#date "+%d/%m/%Y" -d "$d/$m/$y" 2>1 > /dev/null
	# MAC OS X: 
	date -f "%m/%d/%Y" -j "$2/$1/$3" >/dev/null 2>&1
	is_valid=$?
	if [ $is_valid -eq 1 ]
	then
		echo "Incorrect date. Program terminated!"
		exit 1
	fi
}


oldIFS="$IFS" #internal fields separator
IFS="-"

echo "Enter date (format dd-mm-yyyy)"
read d m y
isDate $d $m $y

echo "${y}${m}${d}0000"
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

a=$(find . -type f \! -newer dstamp -not -name dstamp -print | head -n 100) #exclude dstamp(!)
n=$(echo "$a" | wc -l) # number of files


#if empty - 0 files

if test -z "$a"
then
	n=0
fi


echo $a >> "$fn"
echo "---------------------------------" >> "$fn"
echo "$n file(s) found" >> "$fn"

rm dstamp #revome temporary

exit 0 