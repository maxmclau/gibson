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

# tput Color Capabilities:
## tput setab [1-7] – Set a background color using ANSI escape
## tput setb [1-7] – Set a background color
## tput setaf [1-7] – Set a foreground color using ANSI escape
## tput setf [1-7] – Set a foreground color

# tput Text Mode Capabilities:
## tput bold – Set bold mode
## tput dim – turn on half-bright mode
## tput smul – begin underline mode
## tput rmul – exit underline mode
## tput smso – Enter standout mode (bold on rxvt)
## tput rmso – Exit standout mode
## tput sgr0 – Turn off all attributes

# Color Code for tput:
## 0 – Black
## 1 – Red
## 2 – Green
## 3 – Yellow
## 4 – Blue
## 5 – Magenta
## 6 – Cyan
## 7 – White

# GUI : Render
function renderGui () {
  tput clear
  tput civis  # Hide cursor

  _guiDisplayHeader 6 4 " GIBSON_* :: ネットワーク " 2

  # TODO : Fix this so it's more objective
  _guiDisplaySettings 10 8 "User:$USER"                          \
                           "Board Name:$boardName"		           \
                           "Board Tag:$boardTag"			           \
                           "Board Arch:$boardArch"						   \
                           "Directory:$PWD"										   \
                           "Arduino.app:$dirArduinoJava"			   \
                           "Build Tool:$pathArduinoBuilder"	     \
                           "Build Path:$dirProjectBuild"         \
                           "Sketch:$pathProjectSketch"

  _guiDisplayAction "./gibson.sh"

  _guiDisplayProgress 100 100
}

# GUI : Update progressbar
# $1  progressbar-progress
# $2  progressbar-total
function guiUpdateProgress () {
  _guiDisplayProgress $1 $2

  tput ll
}

# GUI : Update Actions
# $1  action-log
function guiUpdateActions () {
  _guiDisplayAction $1

  tput ll
}


# GUI : Header
# Uses tPut to print out gui header
# $1  x-position
# $2  y-position
# $3  Content
function _guiDisplayHeader () {
  local _xpos=$1
  local _ypos=$2

  tput dim
  tput smso
  tput setaf 6

  tput cup $(($_ypos + 0)) $_xpos
  printf "$3"

  tput cup $(($_ypos + 1)) $_xpos
  printf "$3"

  tput cup $(($_ypos + 2)) $_xpos
  printf "$3"

  tput sgr0

  tput setab 0
  tput setaf 7

  tput cup 1 $(($(tput cols) - 10))
  printf " v0.1"

  tput blink
  tput setaf 6
  printf "* "

  tput sgr0
}

# GUI : Build Information
# $1  x-position
# $2  y-position
function _guiDisplaySettings () {
  local _xpos=$1
  local _ypos=$2
  local _index=0

  for var in "$@" ; do
    local _split
    IFS=':' read -r -a _split <<< "$var"

    # If argument is a string
    re='^[0-9]+$'
    if ! [[ $var =~ $re ]] ; then
      ## Split string at delimiter
      local _title="${_split[0]}"
      local _value="${_split[1]}"

      tput cup $(($_ypos + $_index)) $_xpos

      tput dim
      tput setaf 4
      printf " $_title : "
      tput sgr0


      tput bold
      tput smul
      tput setaf 4
      printf "$_value\n"
      tput sgr0

      _index=$((_index + 1))
    fi
	done

  tput sgr0
}
# GUI : Progress Bar
# $1  action
function _guiDisplayAction () {
  local _xpos=6
  local _ypos=18
  local _action=$1

  tput cup $_ypos $_xpos

  tput dim
  tput smso
  tput setaf 2
  printf " $_action "
  tput sgr0
}

# GUI : Progress Bar
# $3  complete tasks
# $4  total tasks
function _guiDisplayProgress () {
  local _PERCENT_WIDTH=12
  local _xoffset=6
  local _yoffset=2

  local _width=$(($(tput cols) - $(($_xoffset * 2)) - $_PERCENT_WIDTH))
  local _xpos=$_xoffset
  local _ypos=$(($(tput lines)-$_yoffset))

  local _completion=$(echo "$1 / $2" | bc -l)
  local _fill=$(echo "$_completion * $_width" | bc -l)
  local _empty=$(echo "$_width - $_fill" | bc -l)

  local _percent=$(echo "$_completion * 100" | bc -l)

  tput cup $_ypos $_xpos

  tput dim
  tput setaf 2
  printf "[";
  for ((i=1; i<=$(printf "%.0f" $_fill); i++)) ; do printf "✗" ; done

  tput setaf 7
  for ((i=1; i<=$(printf "%.0f" $_empty); i++)) ; do printf "⋅" ; done

  tput setaf 2
  printf "]";

  tput setaf 5
  printf " %0.2f %%" $_percent

  tput sgr0
}

# GUI : Modal
# $1  content
# $2  ansi color
function _guiDisplayModal () {
  local _content=$1

  local _width=$(($(tput cols)))
  local _height=$(($(tput lines)))

  local _size=${#_content}

  local _xposFloat=$(echo "($_width / 2) - ($_size / 2)" | bc -l)
  local _yposFloat=$(echo "($_height / 2) - 2" | bc -l)

  local _xpos=$(printf "%.0f" $_xposFloat)
  local _ypos=$(printf "%.0f" $_yposFloat)

  tput cup $_ypos $_xpos
  tput bold
  tput smso
  tput blink
  tput setaf "$2"

  printf "$1"

  tput sgr0

  tput setaf "$2"
  tput setab "$2"
  # Quick and easy boarder with same sizes
  tput cup $(($_ypos - 1 )) $_xpos
  printf "$1"
  tput cup $(($_ypos + 1 )) $_xpos
  printf "$1"
  tput sgr0

  # We display progress because it updates the cursor
  # towards the bottom of our screen preventing the
  # new shell from appearing in the center
  _guiDisplayProgress $_progress 100
}
