#!/bin/bash

#ifdef __USAGE
#created by Vladislav Alexeyev
#November, 24 2014
#SYNTAX: prg_find [path]
#endif

#Enter dates to search

oldIFS="$IFS"
IFS=":"


#Data write
echo -n "Enter date (format dd:mm:yyyy) "
read d m y

echo $d
echo $m 
echo $y

if test -z $d || test -z $m || test -z $y
then
echo "Failed date. Exited "
exit 1
fi

IFS="oldifs"

#Find
tmp="/root -${RANDOM}${RANDOM}"
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
