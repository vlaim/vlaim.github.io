#!/bin/bash

#ifdef __USAGE
#created by Vladislav Alexeyev
#November, 24 2014
#SYNTAX: prg_find [path]
#endif



# Terminates program if input date is incorrect
function isDate
{
	# MAC OS X: 
	#date "+%d/%m/%Y" -d "$d/$m/$y" 2>1 > /dev/null
	#Other: 
	date -f "%m/%d/%Y" -j "$d/$m/$y" >/dev/null 2>&1
	is_valid=$?
	echo $is_valid
	if [ $is_valid -eq 1 ]
	then
		echo "Incorrect date. Program terminated!"
		exit 1
	fi
}

#Enter dates to search

oldIFS="$IFS"
IFS=":"

#Data write
echo "Enter date (format dd:mm:yyyy)"
read d m y
isDate d m y

IFS="oldifs"

#Find
#tmp="/root -${RANDOM}${RANDOM}"
tmp = "/"

touch -t "${y}${m}${d}0000" "tmp"

a=$(find $(pwd) -type f -newer "$tmp" -print)

n=$(echo "$a" |wc -l)

if test -z "$a"
then
n=0
fi

a=$(echo "$a" | head -n 100)
 
echo -n "Enter filename (FIND.TXT as default)"
read fn
if test -z "$fn"
then
fn="FIND.TXT"
fi

if test -f "$fn"
then
echo -n "$fn exist. Rewrite? y/n: "
read yn
fi

if test "$yn"="y" || "$yn"="Y"
then
echo "$a" > "$fn"
else
echo "$a" >> "$fn"
fi

echo "-----------------------------------------" >> "$fn"
echo "$n files found" >> "$fn"

rm "$tmp"

exit 0
