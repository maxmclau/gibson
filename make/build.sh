#
# Includes
. $PROJECT_MAKE_DIR/_helpers.sh

$ARDUINO_BUILDER_PATH										\
	-logger=machine												\
	-hardware	$PROJECT_HARDWARE_DIR				\
	-hardware	$ARDUINO_HARDWARE_DIR				\
	-tools $ARDUINO_BUILDER_TOOLS_DIR			\
	-tools $ARDUINO_AVR_TOOLS_DIR					\
	-libraries $PROJECT_LIBRARIES_DIR			\
	-libraries $ARDUINO_LIBS_DIR					\
	-build-path $PROJECT_BUILD_DIR				\
	-fqbn $BOARD_QUALIFIED_FULL_NAME			\
	-warnings=all													\
	-prefs=build.warn_data_percentage=75	\
	$PROJECT_SKETCH_PATH									\
	>$PROJECT_BUILD_DIR/build.log &

#
# Log arduino-builder process id
pid=$!

#
# We monitor the arduino-builder and append 'exit'
# on the log when it terminates
while true ; do
	if ! ps -p $pid > /dev/null ; then
		echo "exit" >> "$PROJECT_BUILD_DIR/build.log"
		break
	fi
done &

#
# Iterate through logfile
tail -n 0 -F $PROJECT_BUILD_DIR/build.log | \
while read line ; do
	if [ "$line" == "exit" ] ; then
		# TODO : replace this super gangster killall function
		#	with something more pointed
		killall tail
		exit
	fi


	# Return string with progress
	# ===info ||| Progress {0} ||| [0.00]
	_progressRaw=$(echo "$line" | grep '===info ||| Progress')
	#	Pull value between []
	_progress=$(echo $_progressRaw | cut -d "[" -f2 | cut -d "]" -f1)

	if [ -n "$_progress" ] ; then
	progressBar 32 $(printf "%.0f" $_progress) 100
	fi
done
