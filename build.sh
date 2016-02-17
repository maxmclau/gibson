#!/bin/sh
#
# Includes
. print.sh

#
# Parse arguments for script
while echo $1 | grep -q ^-; do
	eval $( echo $1 | sed 's/^--//' )=$2
	shift
	shift
done

#
# Assign directories
# Project specific directories
PROJECT_ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_BUILD_DIR=$PROJECT_ROOT_DIR/build
PROJECT_HARDWARE_DIR=$PROJECT_ROOT_DIR/hardware
PROJECT_LIBRARIES_DIR=$PROJECT_ROOT_DIR/libraries

#	Arduino specific directories
ARDUINO_JAVA_DIR="/Applications/Arduino.app/Contents/Java"
ARDUINO_HARDWARE_DIR=ARDUINO_JAVA_DIR/hardware
ARDUINO_LIBRARIES_DIR=ARDUINO_JAVA_DIR/libraries
ARDUINO_BUILDER_PATH=ARDUINO_JAVA_DIR/arduino-builder
ARDUINO_BUILDER_TOOLS_DIR=ARDUINO_JAVA_DIR/tools-builder
ARDUINO_AVR_TOOLS_DIR=ARDUINO_JAVA_DIR/hardware/tools/avr

echo $host;

#
# Board specific
if [ -z "$board" ]
then
	echo "The variable MyVar has nothing in it."
elif ! [ -z "$board-name" ]
then
	echo "The variable MyVar has something in it."
fi

#BOARD_QUALIFIED_FULL_NAME=$BOARD_NAME:$BOARD_ARCHITECTURE:$BOARD_TAG



#
# Check and create directories
# Project build directory
#printf "Text in ${red}red${end}, white and ${blu}blue${end}.${br}"
#printf "$BOARD_QUALIFIED_FULL_NAME"


cd $PROJECT_DIR