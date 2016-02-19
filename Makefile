#
# Constants
# TODO : make this an external config file for multiple profiles
export BOARD_NAME										= atmega256rfr2
export BOARD_ARCHITECTURE						= avr
export BOARD_TAG										= 256RFR2XPRO

SKETCH_PATH													= main.cpp

#
# Paths and Directories
LOCAL_APPS_DIR										 := /Applications

## Project specific
export PROJECT_MAKE_DIR						 :=	$(PWD)/make
export PROJECT_BUILD_DIR					 :=	$(PWD)/_build
export PROJECT_HARDWARE_DIR				 :=	$(PWD)/hardware
export PROJECT_LIBRARIES_DIR			 :=	$(PWD)/libraries
export PROJECT_SKETCH_PATH				 :=	$(PWD)/$(SKETCH_PATH)

## Arduino specific
export ARDUINO_JAVA_DIR						 :=	$(LOCAL_APPS_DIR)/Arduino.app/Contents/Java
export ARDUINO_HARDWARE_DIR			   := $(ARDUINO_JAVA_DIR)/hardware
export ARDUINO_LIBS_DIR					   := $(ARDUINO_JAVA_DIR)/libraries
export ARDUINO_BUILDER_PATH			   := $(ARDUINO_JAVA_DIR)/arduino-builder
export ARDUINO_BUILDER_TOOLS_DIR	 :=	$(ARDUINO_JAVA_DIR)/tools-builder
export ARDUINO_AVR_TOOLS_DIR			 :=	$(ARDUINO_JAVA_DIR)/hardware/tools/avr

## Board specific
export BOARD_QUALIFIED_FULL_NAME	 := $(BOARD_NAME):$(BOARD_ARCHITECTURE):$(BOARD_TAG)

# Default to build target
all: build

build: init clean
	@sh $(PROJECT_MAKE_DIR)/build.sh

clean: init
	@sh $(PROJECT_MAKE_DIR)/clean.sh

init:
	@sh $(PROJECT_MAKE_DIR)/init.sh