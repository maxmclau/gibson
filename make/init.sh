#!/bin/sh
#

#
# Includes
. $PROJECT_MAKE_DIR/_helpers.sh

#
# Display header
printHeader "Board Name:$BOARD_NAME"						\
						"Board Tag:$BOARD_ARCHITECTURE"			\
						"Board Arch:$BOARD_TAG"							\
						"Directory:$PWD"										\
						"Arduino.app:$ARDUINO_JAVA_DIR"			\
						"Build Tool:$ARDUINO_BUILDER_PATH"	\
						"Sketch:$PROJECT_SKETCH_PATH"				\
						"Build Path:$PROJECT_BUILD_DIR"\