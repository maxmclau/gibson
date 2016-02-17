# Miscellaneous
# ----------------------------------
# Manage path with space in the name
#

PROJECT_HARDWARE_DIR				=	$(PROJECT_DIR)/hardware
PROJECT_LIBRARIES_DIR				=	$(PROJECT_DIR)/libraries

ARDUINO_JAVA_DIR						=	$(LOCAL_APPS_DIR)/Arduino.app/Contents/Java
ARDUINO_HARDWARE_DIR				= $(ARDUINO_JAVA_DIR)/hardware
ARDUINO_LIBS_DIR						= $(ARDUINO_JAVA_DIR)/libraries
ARDUINO_BUILDER_PATH				= $(ARDUINO_JAVA_DIR)/arduino-builder
ARDUINO_BUILDER_TOOLS_DIR		=	$(ARDUINO_JAVA_DIR)/tools-builder
ARDUINO_AVR_TOOLS_DIR				=	$(ARDUINO_JAVA_DIR)/hardware/tools/avr

BOARD_QUALIFIED_FULL_NAME		= $(BOARD_NAME):$(BOARD_ARCHITECTURE):$(BOARD_TAG)

all:
	@echo $(BOARD_QUALIFIED_FULL_NAME)

build:
	./build