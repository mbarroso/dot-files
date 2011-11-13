#!/bin/sh
#find $1 -type f -print0 | xargs -0 sed -i 's/$2/$3/g'
echo $1 $2 $3
grep -rl $2 $1 | while read fn; do
	echo "replacing in $fn $2 for $3"
	sed -i "s/$2/$3/g" $fn
done
