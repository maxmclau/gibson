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

function build () {
  

  $pathArduinoBuilder										          \
    	-logger=machine												      \
    	-hardware	$dirProjectHardware				        \
    	-hardware	$dirArduinoHardware				        \
    	-tools $dirArduinoBuilderTools					    \
    	-tools $dirArduinoAvrTools			            \
    	-libraries $dirProjectLibraries			        \
    	-built-in-libraries $dirArduinoLibraries    \
    	-build-path $dirProjectBuild				        \
    	-fqbn $boardQualifiedFullName			          \
    	-warnings=all													      \
    	-prefs=build.warn_data_percentage=75	      \
    	$pathProjectSketch
}
