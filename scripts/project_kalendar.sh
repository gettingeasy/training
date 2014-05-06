#!/bin/bash
# Project Kalendar:
# surpport add/modify/removes/lookup events
#04/2014
#PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
#export PATH
file=$1
lan=$2
yn=y
month=0
add ()
{
	sed '/^'"$eg"', date: */!d; s///;q' $lan
	read mm dd
	sed '/^'"$eg"', event: */!d; s///;q' $lan
	read termin
	check=`sed -n '/^'"$mm, $dd"'$/p' $file`
	sed -i 's/^'"$mm, $dd"'$/'"$mm, $dd, $termin"'/g' $file 
	if [ "$check" == "" ]; then
		sed -i '/^'"$mm, $dd, "'/a '"$mm, $dd, $termin"'' $file
	else
		sed -i 's/^'"$mm, $dd"'$/'"$mm, $dd, $termin"'/g' $file
	fi
	show 
}
remove ()
{
	sed '/^'"$eg"', date: */!d; s///;q' $lan
	read mm dd
	sed '/^'"$eg"', event: */!d; s///;q' $lan
	read Termin
	ne=`sed -n '/^'"$mm, $dd, $Termin"'/p' $file`
                 echo $ne
        if [ "$ne" != "" ]; then
		 sed '/^'"$eg"', sure: */!d; s///;q' $lan
                 read yn
                 if [ "$yn" == "y" ]; then
                 	sed -i '/^'"$mm, $dd, $Termin"'/d' $file
			check=`sed -n '/^'"$mm, $dd,"'.*/p' $file`
			if [ "$check" == "" ]; then
				pre=`expr $dd - 1`
				p=`sed -n '/^'"$mm, $pre"'$/h; ${x;p}' $file`
				sed -i '/^'"$p"'/a '"$mm, $dd"'' $file
			fi
                 fi
        else
                 sed '/^'"$eg"', exist: */!d; s///;q' $lan
        fi
	show
}
modify ()
{
	show
	sed '/^'"$eg"', date: */!d; s///;q' $lan
	read mm dd
	en=`sed -n '/^'"$mm, $dd"'/p' $file`
	if [ "$en" == "" ]; then
		sed '/^'"$eg"', exist: */!d; s///;q' $lan
	else
		sed '/^'"$eg"', event: */!d; s///;q' $lan
		read Termin
		ne=`sed -n '/^'"$mm, $dd, $Termin"'/p' $file`
		echo $ne
		if [ "$ne" != "" ]; then
			sed '/^'"$eg"', sure: */!d; s///;q' $lan
	    		read yn
			if [ "$yn" == "y" ]; then
				sed '/^'"$eg"', assign: */!d; s///;q' $lan
				read neu
				sed -i '/^'"$mm, $dd, $Termin"'/s/'"$Termin"'/'"$neu"'/g' $file
				show
			fi
		else 
	    		sed '/^'"$eg"', exist: */!d; s///;q' $lan 
		fi
	fi
}
showall()
{
awk -F, '
{
	print $1 ", " $2 ", " $3 
	}' $file $* | sort -n |
awk -F, ' 
$1 != LastMonth {
	LastMonth = $1
	print $1
	LastDay = $2
	print "\t" $2 $3

}
$1 == LastMonth && LastDay != $2 {
	print "\t" $2 $3
}' 
}
show()
{
awk -F, '
{
print $1 ", " $2 ", " $3 
         }' $file $* | sort -n -k 2 |
awk -F, ' $1 == m {
print $1 $2 $3
}
' m="$month" -

}

read -p "English or German? (en/de) " eg

while [ "$yn" == "y" ]
do
sed '/^'"$eg"', view: */!d; s///;q' $lan
read yn
if [ "$yn" == "y" ]; then
sed '/^'"$eg"', browse:*/!d; s///;q' $lan
read month
show
fi
while [ "$yn" != "q" ]
do
	sed '/^'"$eg"', edit: */!d; s///;q' $lan
	read yn
	if [ "$yn" == "Y" ] || [ "$yn" == "y" ]; then
		sed '/^'"$eg"', act: */!d; s///;q' $lan
		read forden
	case $forden in
		"1")
			add
			;;
		"2")
			remove
			;;
		"3")
			modify
			;;
	esac
	elif  [ "$yn" == "N" ] || [ "$yn" == "n" ]; then
		sed '/^'"$eg"', quit: */!d; s///;q' $lan
		read yn
	fi
done
done
exit 0

