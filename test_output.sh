# Utility script to run the unit tests locally and report success/failure from the command line.

./check_unity_unit_test_result.sh

rc=$?
if [[ $rc != 0 ]] ; then
	echo "Fail"
else
	echo "Success"
fi

