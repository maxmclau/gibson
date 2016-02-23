#!/bin/bash

# Copyright 2016 Project Moa

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#    http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Usage
# ./gibson.sh --build -n atmega256rfr2 -a avr -t 256RFR2XPRO -f main.cpp

# Includes : All
. /Users/maxmillionmclaughlin/Moa/gibson/inc/helpers.sh
. /Users/maxmillionmclaughlin/Moa/gibson/inc/gui.sh
. /Users/maxmillionmclaughlin/Moa/gibson/inc/build.sh
. /Users/maxmillionmclaughlin/Moa/gibson/inc/clean.sh

# Main : Arguments
# Use > 1 to consume two arguments per pass in the loop (e.g. each
# argument has a corresponding value to go with it).
# Use > 0 to consume one or more arguments per pass in the loop (e.g.
# some arguments don't have a corresponding value to go with it such
# as in the --default example).
while [[ $# > 1 ]] ; do
  argument="$1"

  case $argument in
    -n|--name)
      boardName="$2"
      shift ;;

    -a|--architecture)
      boardArch="$2"
      shift ;;

    -t|--tag)
      boardTag="$2"
      shift ;;

    -f|--file)
      sketchName="$2"
      shift ;;

    --build|--upload|--clean)
      action=$(stringRemoveHyphens "$1")
      ;;

    *)
      # unkown
      ;;
  esac
shift
done

# Variables : Build
declare -x action

declare -x boardName
declare -x boardArch
declare -x boardTag

declare -x sketchName

# Variables : Directories and Paths
declare -x dirLocalApplications=/Applications
declare -x dirProjectBuild=$PWD/_build
declare -x dirProjectHardware=$PWD/hardware
declare -x dirProjectLibraries=$PWD/libraries

declare -x pathProjectSketch=$PWD/$sketchName

declare -x dirArduinoJava=$dirLocalApplications/Arduino.app/Contents/Java
declare -x dirArduinoHardware=$dirArduinoJava/hardware
declare -x dirArduinoLibraries=$dirArduinoJava/libraries
declare -x dirArduinoBuilderTools=$dirArduinoJava/tools-builder
declare -x dirArduinoAvrTools=$dirArduinoJava/hardware/tools/avr

declare -x pathArduinoBuilder=$dirArduinoJava/arduino-builder

declare -x boardQualifiedFullName=$boardName:$boardArch:$boardTag

# Main : Init
renderGui

clean
exec 3< <(build)

# Read up
while read <&3 line ; do
  # If line begins with ===info ||| Progress {0} |||
  if [[ $line == "===info ||| Progress {0} ||| "* ]] ; then
    _progressFloat=$(echo $line | cut -d "[" -f2 | cut -d "]" -f1)
    _progress=$(printf "%.0f" $_progressFloat)

    guiUpdateProgress $_progress 100

    if [ "$_progress" -ge 100 ] ; then
      _guiDisplayModal "  羽鳥 BUILD COMPLETE ペニス  " 2
    fi
  fi
done

exitHandler () {
  tput cnorm  # Display cursor

  if [ "$_progress" -lt 100 ] ; then
    _guiDisplayModal "  いです SHIT'S WEAK 君は  " 1
  fi

  exit
}

trap exitHandler SIGINT
trap exitHandler EXIT
