#
# Constants
# TODO : make this an external config file for multiple profiles
export BOARD_NAME										= atmega256rfr2
export BOARD_ARCHITECTURE						= avr
export BOARD_TAG										= 256RFR2XPRO

export AVRDUDE_PROGRAMMER						= stk600
export AVRDUDE_PART									= m256rfr2

SKETCH_PATH													= main.ino

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




all: build

build: init
	@sh $(PROJECT_MAKE_DIR)/build.sh

upload: init
	@sh $(PROJECT_MAKE_DIR)upload.sh

init: clean
	@cd $(PWD)
	@sh $(PROJECT_MAKE_DIR)/init.sh

clean:
	@sh $(PROJECT_MAKE_DIR)/clean.sh