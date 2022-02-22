#!/bin/bash
OPTION="text"
NAME=""
CATALOG=""
PERMISSION=""
REG=""
CONTENT=""
MODIFICATION=""
while [[ "$OPTION" != "Finish" ]]
do
	MENU=("File name: $NAME" "Catalog: $CATALOG" "Permission: $PERMISSION" "Type: $REG" "Modification date in days: $MODIFICATION" "File content: $CONTENT" "Search" "Finish")
	OPTION=$(zenity --list --column=Menu "${MENU[@]}" --width 500 --height 400)
	
	if [[ $OPTION == "File name: $NAME" ]]; then
		NAME=$(zenity --entry --text "Enter file name: ")
		if [[ ${#NAME} -ne 0 ]]; then
			NAME_OPT="-name $NAME"
		else
			NAME_OPT=""
		fi
	elif [[ "$OPTION" == "Catalog: $CATALOG" ]]; then
		CATALOG=$(zenity --entry --text "Enter catalog: ")
		
	elif [[ "$OPTION" == "Type: $REG" ]]; then
		echo "Enter type of item: "
		REG=$(zenity --entry --text "Enter type of item: ")
		if [[ ${#REG} -ne 0 ]]; then
			TYPE_OPT="-type $REG"
		else
			TYPE_OPT=""
		fi
	elif [[ "$OPTION" == "Permission: $PERMISSION" ]]; then
		PERMISSION=$(zenity --entry --text "Enter permission in nnn form: ")
		if [[ ${#PERMISSION} -ne 0 ]]; then
			PERMISSION_OPT="-perm $PERMISSION"
		else
			PERMISSION_OPT=""
		fi
	elif [[ "$OPTION" == "Modification date in days: $MODIFICATION" ]]; then
		MODIFICATION=$(zenity --entry --text "Enter modification date in days (type + before if you mean older than, and - if you mean younger than): ")
		if [[ ${#MODIFICATION} -ne 0 ]]; then
			MODIFICATION_OPT="-mtime $MODIFICATION -daystart"
		else
			MODIFICATION_OPT=""
		fi
	elif [[ "$OPTION" == "File content: $CONTENT" ]]; then
		CONTENT=$(zenity --entry --text "Enter desired phrase: ")
		if [[ ${#CONTENT} -ne 0 ]]; then
			CONTENT_OPT="-exec grep -iRls $CONTENT {} +"
		else
			CONTENT_OPT=""
		fi
	elif [[ "$OPTION" == "Search" ]]; then
		RESULT=$(find $CATALOG $NAME_OPT $TYPE_OPT $MODIFICATION_OPT $PERMISSION_OPT $CONTENT_OPT | sort | uniq)
		zenity --info --title "Results: " --text "$RESULT" --width=600 --height=400
	fi
done

