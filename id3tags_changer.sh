#!/bin/bash

# Author          :Olaf ( olafs305@gmail.com )
# Created On      :xx.01.2022
# Last Modified By:Olaf ( olafs305@gmail.com )
# Last Modified On:07.01.2022
# Version         :0.0.2
#
# Description     : Programm that allows to change ID3TAG of mp3 files by reading 
# reading their name with structure information provided

array=( "$@" )
match='^[0-9][0-9][0-9][0-9]$'
suffix=".mp3"
access_path=""
arraylength=${#array[@]}

help_opt() {
	echo "This program is changing ID3TAG of a mp3 file based on its name and given structure string
	NAME: 
		tagger3 - operations on id3tags of mp3 files
	SYNOPSIS: 
		./tagger3.sh [-d (optional) parameter] [file_name] [-s  structure_string] 
		./tagger3.sh [-h] 
		./tagger3.sh [-v] 
	OPTIONS: 
		file_name -
		  -name of the mp3 file we want to change (without directory and with .mp3 extension included)
		-d directory -
		  -specify name of path/directory where are your files 
		  -start and end directory name with '/' symbol E.g. /home/liveuser/Downloads/
		  -if this option wont be choosen program will change names of files
		    that are in the same directory that this program is
		-s structure - 
		  -specify whay part of files name represents certain tags and separate them with appropriate separators
		  -TAGS: a - artist
			 y - year
			 A - album
			 t - title
		-h help - 
		  -prints help message
		-v version - 
		  -prints information about version
	EXAMPLES:
		Change title, year and artist tags of file Billy_Michalel.Jackson_2002.mp3 
			./tagger3.sh Billy_Michalel.Jackson_2002.mp3 -s t_a_y
		Change title, year, album and artist tags of file 2039-Butterfly-Travis-Sicko.mp3 in directory /home/liveuser/Documents/
			./tagger3.sh -d /home/liveuser/Documents/ 2039-Butterfly-Travis-Sicko.mp3 -s y-t-a-A "
}

s_option() {
	for (( j=0; j<${#structure}; j++ )); do
	  	current="${structure:$j:1}"
		if [[ "$current" == "y" ]]; then
			if [[ j -ne ${#structure}-1 ]]; then
				separator="${structure:$j+1:1}"
				yeare=${file_name%%${separator}*}
				file_name=${file_name#*${separator}}
			else
				yeare=$file_name
			fi
			if [[ $yeare =~ $match ]]; then
				year="$yeare"
			else
				echo "ERROR: Year must be a 4-digit number"
				exit 1
			fi
		elif [[ "$current" == "a" ]]; then
			if [[ j -ne ${#structure}-1 ]]; then
				separator="${structure:$j+1:1}"
				artist=${file_name%%${separator}*}
				file_name=${file_name#*${separator}}
			else
				artist=$file_name
			fi
		elif [[ "$current" == "t" ]]; then
			if [[ j -ne ${#structure}-1 ]]; then
				separator="${structure:$j+1:1}"
				title=${file_name%%${separator}*}
				file_name=${file_name#*${separator}}
			else
				title=$file_name
			fi
		elif [[ "$current" == "A" ]]; then
			if [[ j -ne ${#structure}-1 ]]; then
				separator="${structure:$j+1:1}"
				album=${file_name%%${separator}*}
				file_name=${file_name#*${separator}}
			else
				album=$file_name
			fi
		fi
	done
	id3v2 -a "$artist" "$access_path""$our_file"
	id3v2 -A "$album" "$access_path""$our_file"
	id3v2 -y "$year" "$access_path""$our_file"
	id3v2 -t "$title" "$access_path""$our_file"
}


for (( i=0; i<${arraylength}; i++ ));
do
	if [[ "${array[$i]}" == "-h" ]]; then
		help_opt
	elif [[ "${array[$i]}" == "-s" ]]; then
		our_file=${array[$i-1]}
		structure=${array[$i+1]}
		file_name=${our_file%"$suffix"}
		s_option
	elif [[ "${array[$i]}" == "-v" ]]; then
		echo "# Version: 0.0.2"
		echo "# Author: Olaf Serafin"
		echo "# Email: olafs305@gmail.com"
	elif [[ "${array[$i]}" == "-d" ]]; then
		access_path=${array[$i+1]}
		
	fi
done

	


