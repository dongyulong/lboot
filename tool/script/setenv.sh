#!/bin/bash

export TOPDIR=`pwd`

LUNCH_MENU_CHOICES=([0]=TQ2440  [1]=Uplooking2440)

function print_lunch_menu()
{
    local uname=$(uname)
    echo
    echo "You're building on" $uname
    echo
    echo "Lunch menu... pick a combo:"

    local i=1
    local choice
    for choice in ${LUNCH_MENU_CHOICES[@]}
    do
        echo "     $i. $choice"
        i=$(($i+1))
    done

    echo
}

function lunch()
{
    local answer

    if [ "$1" ] ; then
        answer=$1
    else
        print_lunch_menu
        echo -n "Which would you like? [TQ2440] "
        read answer
    fi

    local selection=

    if [ -z "$answer" ]
    then
        selection=TQ2440
    elif (echo -n $answer | grep -q -e "^[0-9][0-9]*$")
    then
        if [ $answer -le ${#LUNCH_MENU_CHOICES[@]} ]
        then
            selection=${LUNCH_MENU_CHOICES[$(($answer-1))]}
        fi
    elif (echo -n $answer | grep -q -e "^[^\-][^\-]*-[^\-][^\-]*$")
    then
        selection=$answer
    fi

    if [ -z "$selection" ]
    then
        echo
        echo "Invalid lunch combo: $answer"
        return 1
    fi

    local product=$(echo -n $selection | sed -e "s/-.*$//")

	if [ "$selection" = "Uplooking2440" ]
	then 
#		echo "uplooking"
		export UPLOOKING=1
		echo "#define UPLOOKING" > include/variant.h
	else
		export UPLOOKING=0
		echo " " > include/variant.h
	fi

}

function croot()
{
	cd $TOPDIR
}


export lunch
export croot


export PATH=$TOPDIR/tool/script:$PATH





