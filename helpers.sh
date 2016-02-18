#!/bin/sh
#
####
# PRINTF HELPER
####
#
# Constants
let TITLE_WIDTH=26;

#
# Printf color shortcuts
# Stolen from:
# http://stackoverflow.com/questions/16843382/colored-shell-script-output-library
# Echo works - sort of. There are some strange complications with zsh and it's all
#	around less predictable so we go with trusty printf
# Usage
# printf "Text in ${Red}red${RCol}, white and ${Blu}blue${RCol}."
#
# Text Reset
RCol='\e[0m'

# Line break
BR=$'%s\n'

# Regular           Bold                Underline           High Intensity      BoldHigh Intens     Background          High Intensity Backgrounds
Bla='\e[0;30m';     BBla='\e[1;30m';    UBla='\e[4;30m';    IBla='\e[0;90m';    BIBla='\e[1;90m';   On_Bla='\e[40m';    On_IBla='\e[0;100m';
Red='\e[0;31m';     BRed='\e[1;31m';    URed='\e[4;31m';    IRed='\e[0;91m';    BIRed='\e[1;91m';   On_Red='\e[41m';    On_IRed='\e[0;101m';
Gre='\e[0;32m';     BGre='\e[1;32m';    UGre='\e[4;32m';    IGre='\e[0;92m';    BIGre='\e[1;92m';   On_Gre='\e[42m';    On_IGre='\e[0;102m';
Yel='\e[0;33m';     BYel='\e[1;33m';    UYel='\e[4;33m';    IYel='\e[0;93m';    BIYel='\e[1;93m';   On_Yel='\e[43m';    On_IYel='\e[0;103m';
Blu='\e[0;34m';     BBlu='\e[1;34m';    UBlu='\e[4;34m';    IBlu='\e[0;94m';    BIBlu='\e[1;94m';   On_Blu='\e[44m';    On_IBlu='\e[0;104m';
Pur='\e[0;35m';     BPur='\e[1;35m';    UPur='\e[4;35m';    IPur='\e[0;95m';    BIPur='\e[1;95m';   On_Pur='\e[45m';    On_IPur='\e[0;105m';
Cya='\e[0;36m';     BCya='\e[1;36m';    UCya='\e[4;36m';    ICya='\e[0;96m';    BICya='\e[1;96m';   On_Cya='\e[46m';    On_ICya='\e[0;106m';
Whi='\e[0;37m';     BWhi='\e[1;37m';    UWhi='\e[4;37m';    IWhi='\e[0;97m';    BIWhi='\e[1;97m';   On_Whi='\e[47m';    On_IWhi='\e[0;107m';

#
# Private printf function
#	A cleaner wrapper for printf
#
# Arguments
#	-l		:	Line content
#	-m		:	Modifier (color, background)
#	-e		:	Line break
#	-d		:	Divider, yes or no
#	-p		:	Prefix with class
#	-s		:	Line size restraint
#
_print() {
	local _string
	local _line
	local _modifier
	local _size
	local _divider

	local __end=false
	local __spacer=false
	local __indent=false

	# Parse incoming arguments
	# Use > 1 to consume two arguments per pass in the loop (e.g. each
	# argument has a corresponding value to go with it).
	# Use > 0 to consume one or more arguments per pass in the loop (e.g.
	# some arguments don't have a corresponding value to go with it such
	# as in the --default example).
	while [[ $# > 0 ]] ; do
		key="$1"

		case $key in

			-l|--line )
				_line="$2";
				shift ;;

			-m|--modifier )
				case $2 in
					"black" )
						_modifier=${Bla} ;;
					"red" )
						_modifier=${Red} ;;
					"green" )
						_modifier=${Gre} ;;
					"yellow" )
						_modifier=${Yel} ;;
					"blue" )
						_modifier=${Blu} ;;
					"purple" )
						_modifier=${Pur} ;;
					"cyan" )
						_modifier=${Cyn} ;;
					"white" )
						_modifier=${Whi} ;;
				esac
				shift ;;

			-s|--size )
				_size="$2"
				shift ;;

			-d|--divider )
				_divider="$2"
				shift ;;

			-e|--end )
				__end=true
				;;

			-i|--indent )
				__indent=true
				;;

			--spacer )
				__spacer=true
				;;
		esac
		shift
	done

	if [ "$__indent" == true ] ; then
		_string+=" "
	fi

	if [ "$__spacer" == true ] ; then
		printf "${BR}"
		return;
	fi

	if [ "$_divider" == "pre" ] ; then
		_string+=" :: "
	fi

	_string+="${_modifier}"
	_string+="${_line}"
	_string+="${RCol}"

	if [ "$__end" == true ] ; then
		_string+="${BR}"
	fi

	if [ "$_size" ]	; then
		if [ "$_size" -gt "${#_string}" ] ; then
			delta="$(echo "$_size - ${#_string}" | bc)"
			for i in `seq 1 $delta`
			do
				_string+=" "
			done
		fi
	fi

	if [ "$_divider" == "suf" ] ; then
		_string+=" :: "
	fi

	printf "$_string"
}

#
# Print init ASCii
printHeader () {
	_print -l " _____ _____ _____ " -m purple -e -i
	_print -l "|     |     |  _  |" -m purple -e -i
	_print -l "| | | |  |  |     |" -m purple -e -i
	_print -l "|_|_|_|_____|__|__|" -m purple -e -i
	_print --spacer

	for var in "$@" ; do
		local _split

		# Split string at delimiter
		IFS=':' read -r -a _split <<< "$var"

		local _title="${_split[0]}";
		local _value="${_split[1]}";

		_print -l "$_title" -m blue -d suf -s $TITLE_WIDTH -i
		_print -l "$_value" -m yellow -e -i
	done

	_print --spacer
}

####
# PROGRESS BAR HELPER
####
#
# Function to draw progress bar
progressBar () {
	let _width=$1
	let _complete=$2
	let _total=$3

	let	__full=false;

	# Calculate number of fill/empty slots in the bar
	progress=$(echo "$_width/$_total*$_complete" | bc -l)
		fill=$(printf "%.0f\n" $progress)
	if [ $fill -gt $_width ] ; then
		fill=$_width
	fi
	empty=$(($fill-$_width))

	# Percentage Calculation
	percent=$(echo "100/$_total*$_complete" | bc -l)
	percent=$(printf "%0.2f\n" $percent)

	if [ $(echo "$percent>100" | bc) -gt 0 ]; then
		percent="100.00"
		__full=true;
	fi

	# Output to screen
	_print -l "\r [ " -m white
	_print -l "%${fill}s" '' -m purple | tr ' ' ▉
	_print -l "%${empty}s" '' -m purple | tr ' ' ░
	_print -l " ] $percent%% \r" -m white

	if [ "$__full" == true ] ; then
		_print --spacer
	fi
}