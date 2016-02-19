#
# Includes
. $PROJECT_MAKE_DIR/_helpers.sh

if [ -d "$PROJECT_BUILD_DIR" ] ; then
	rm -r $PROJECT_BUILD_DIR
fi

mkdir $PROJECT_BUILD_DIR