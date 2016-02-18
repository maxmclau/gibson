#!/bin/sh
#
# Usage
# ./build.sh --build -n atmega256rfr2 -a avr -t 256RFR2XPRO

#
# Includes
. helpers.sh
. build.sh
. upload.sh
. clean.sh

#
# Execution information
let target

#
# Parse incoming arguments
# Use > 1 to consume two arguments per pass in the loop (e.g. each
# argument has a corresponding value to go with it).
# Use > 0 to consume one or more arguments per pass in the loop (e.g.
# some arguments don't have a corresponding value to go with it such
# as in the --default example).
while [[ $# > 0 ]]
	do
	_key="$1"

	case $_key in
		# TODO : Refactor this so it isn't so hard coded
		--build|--upload|--clean|--serial )
			target="$1";
		;;

		-n|--board-name )
			boardName="$2"
			shift ;;

		-a|--board-arch )
			boardArchitecture="$2"
			shift ;;

		-t|--board-tag )
			boardTag="$2"
			shift ;;

		--default )
			default=true
			;;

		* )
			echo "${red}WARN : Unknown argument :${end} $1"
			exit;
			;;
	esac
	shift
done

#
# Assign directories
# Project specific directories
projectRootDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
projectSketchPath=$projectRootDir/main.cpp
projectBuildDir=$projectRootDir/_build
projectHardwareDir=$projectRootDir/hardware
projectLibrariesDir=$projectRootDir/libraries

#	Arduino specific directories
arduinoJavaDir="/Applications/Arduino.app/Contents/Java"
arduinoHardwareDir=$arduinoJavaDir/hardware
arduinoLibrariesDir=$arduinoJavaDir/libraries
arduinoBuilderTools=$arduinoJavaDir/tools-builder
arduinoBuilderPath=$arduinoJavaDir/arduino-builder
arduinoAvrTools=$arduinoJavaDir/hardware/tools/avr

#
#	Construct board name
boardQualifiedFullName=$boardName:$boardArchitecture:$boardTag

#
# Display header
printHeader "Target:$target"								\
						"Board Name:$boardName"						\
						"Board Tag:$boardTag"							\
						"Directory:$projectRootDir"				\
						"Arduino.app:$arduinoJavaDir"			\
						"Build Tool:$arduinoBuilderPath"

#
# Execute target action
case $target in
	--build )
		clean
		build
	;;

	--upload )
		build
		upload
	;;

	--clean )
		clean
	;;
esac


## Collect task count
