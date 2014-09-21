# Scripts to run the Unity Unit Tests on a CI (Jenkins) slave.

# Removing the previous test results seems to be necessary to get the correct result for the next run.
rm UnitTestResults.xml

# We need to force a refresh of the assets, otherwise the scripts will not be recompiled before the tests are run, and you will end up with the previous test code results
/Applications/Unity/Unity.app/Contents/MacOS/Unity -batchmode -projectPath /Users/david/jenkins_slave/workspace/lwunity -executeMethod AssetDatabase.Refresh 

# After refresh the current state of the code is reflected in the tests
/Applications/Unity/Unity.app/Contents/MacOS/Unity -batchmode -projectPath /Users/david/jenkins_slave/workspace/lwunity -executeMethod UnityTest.UnitTestView.RunAllTestsBatch

if [ ! -f UnitTestResults.xml ]
then
  echo "UnitTestResults.xml does not exist. Exiting..."
  exit 1
fi

# Simply search for a 'success="False"' string to determine if the unit tests succeeded.
if [ $(grep -c "success=\"False\"" UnitTestResults.xml) -ne 0 ];
then
        exit 1
else
        exit 0
fi

