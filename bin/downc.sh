mkdir $1
cd $1
groovy ~/bin/gensh.groovy $2
sh down.sh
rename 'unless (/0+[0-9]{2}.jpg/) {s/^([0-9]{1,3}\.jpg)$/0$1/g;s/0*([0-9]{2}\..*)/$1/}' *
zip -m $1.cbr *.jpg
