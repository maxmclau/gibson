build () {
	cd $projectRootDir

	$arduinoBuilderPath										\
	-logger=machine												\
	-hardware	$projectHardwareDir					\
	-hardware	$arduinoHardwareDir					\
	-tools $arduinoBuilderTools						\
	-tools $arduinoAvrTools								\
	-libraries $arduinoLibrariesDir				\
	-libraries $projectLibrariesDir				\
	-build-path $projectBuildDir					\
	-fqbn $boardQualifiedFullName					\
	-warnings=all													\
	-prefs=build.warn_data_percentage=75	\
	$projectSketchPath										\
	>$projectBuildDir/build.log &

	#
	# arduino-builder Process id
	pid=$!

	while true ; do
		if ps -p $pid > /dev/null ; then
			_error=$((_error+1))
		else
			echo "exit" >> "$projectBuildDir/build.log"
			break;
		fi

		sleep 0.1
	done &

	#
	# Iterate through logfile
	tail -n 0 -F $projectBuildDir/build.log | \
	while read line ; do
		if [ "$line" == "exit" ] ; then
			# TODO : replace this super gangster killall function with something more pointed
			killall tail
			exit;
		fi


		# Return string with progress
		# ===info ||| Progress {0} ||| [0.00]
		local _progressRaw=$(echo "$line" | grep '===info ||| Progress')
		#	Pull value between []
		local _progress=$(echo $_progressRaw | cut -d "[" -f2 | cut -d "]" -f1)

		if [ -n "$_progress" ] ; then
			progressBar 32 $(printf "%.0f" $_progress) 100
		fi
	done

}