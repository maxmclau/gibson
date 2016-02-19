clean () {
	if [ -d "$projectBuildDir" ] ; then
		rm -r $projectBuildDir
	fi

	mkdir $projectBuildDir
}