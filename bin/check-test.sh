sh webserver/test/CIscripts/test-functional.sh > etest.log  2> error.log
TEST_RESULTS=$(grep -ci "tests failed" etest.log)
echo $TEST_RESULTS
