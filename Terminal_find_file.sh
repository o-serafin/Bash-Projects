#!/bin/bash

while [[ $OPTION -ne 8 ]]
do
	echo "1.File name: $NAME "
	echo "2.Catalog: $CATALOG"
	echo "3.Permission: $PERMISSION"
	echo "4.Type: $REG"
	echo "5.Modification date in days: $MODIFICATION"
	echo "6.File content: $CONTENT"
	echo "7.Search"
	echo "8.Finish"
	read OPTION
	if [[ $OPTION -eq 1 ]]; then
		echo "Enter file name: "
		read NAME
		if [[ ${#NAME} -ne 0 ]]; then
			NAME_OPT="-name $NAME"
		else
			NAME_OPT=""
		fi
	elif [[ $OPTION -eq 2 ]]; then
		echo "Enter catalog: "
		read CATALOG
		
	elif [[ $OPTION -eq 4 ]]; then
		echo "Enter type of item: "
		read REG
		if [[ ${#REG} -ne 0 ]]; then
			TYPE_OPT="-type $REG"
		else
			TYPE_OPT=""
		fi
	elif [[ $OPTION -eq 3 ]]; then
		echo "Enter permission in nnn form: "
		read PERMISSION
		if [[ ${#PERMISSION} -ne 0 ]]; then
			PERMISSION_OPT="-perm $PERMISSION"
		else
			PERMISSION_OPT=""
		fi
	elif [[ $OPTION -eq 5 ]]; then
		echo "Enter modification date in days (type + before if you mean older than, and - if you mean younger than): "
		read MODIFICATION
		if [[ ${#MODIFICATION} -ne 0 ]]; then
			MODIFICATION_OPT="-mtime $MODIFICATION -daystart"
		else
			MODIFICATION_OPT=""
		fi
	elif [[ $OPTION -eq 6 ]]; then
		echo "Enter desired phrase:"
		read CONTENT
		if [[ ${#CONTENT} -ne 0 ]]; then
			CONTENT_OPT="-exec grep -iRls $CONTENT {} +"
		else
			CONTENT_OPT=""
		fi
	elif [[ $OPTION -eq 7 ]]; then
		find $CATALOG $NAME_OPT $TYPE_OPT $MODIFICATION_OPT $PERMISSION_OPT $CONTENT_OPT | sort | uniq
	fi
done

