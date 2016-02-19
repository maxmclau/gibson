#
# Paths and Directories
LOCAL_APPS_DIR							= /Applications

## Project specific
PROJECT_HARDWARE_DIR				=	$(PWD)/hardware
PROJECT_LIBRARIES_DIR				=	$(PWD)/libraries

## Arduino specific
ARDUINO_JAVA_DIR						=	$(LOCAL_APPS_DIR)/Arduino.app/Contents/Java
ARDUINO_HARDWARE_DIR				= $(ARDUINO_JAVA_DIR)/hardware
ARDUINO_LIBS_DIR						= $(ARDUINO_JAVA_DIR)/libraries
ARDUINO_BUILDER_PATH				= $(ARDUINO_JAVA_DIR)/arduino-builder
ARDUINO_BUILDER_TOOLS_DIR		=	$(ARDUINO_JAVA_DIR)/tools-builder
ARDUINO_AVR_TOOLS_DIR				=	$(ARDUINO_JAVA_DIR)/hardware/tools/avr

BOARD_QUALIFIED_FULL_NAME		= $(BOARD_NAME):$(BOARD_ARCHITECTURE):$(BOARD_TAG)

all:
	@echo $(PROJECT_HARDWARE_DIR)

build:
#./build