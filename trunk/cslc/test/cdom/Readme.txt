This textfile will tell you how to run the tests
1) Run the make script ($ make )
2) Run the Driver file with the params:
	possible Driver params: 
		-n test_number : set the test number
		-h : get some help
		-f input_test_file : set the input test file
	possible tests:
		0 - test the CVeriNum::CBitArray class
<Invalid>       0 - test the COmSignalPort class
		1 - test the COmSignalSingleton class
		2 - test the COmEvent class
		3 - test the COmExprValInt class
		4 - test the COmExprValReal class
		5 - test the COmStmtAssn class
		6 - test the COmStmtIfElse class
		7 - test the COmStmtLoop class
		8 - test the COmStmtCase class
		9 - test the COmCaseItem class
		10 - test the COmModule class
		11 - test the COmGate class
		12 - test the COmSignalRef class
		13 - test the COmExprOp class
		14 - test the COmParam  class
		15 - test the COmContAssign class
		16 - test the COmProcess class
		17 - test the COmFunction class
		18 - test the COmTask class
		19 - test the COmBitRange class
</Invalid>
example:
$ Driver -n 5 -f testStmtAssn.in
Begin test...
Testing : COmStmtAssn
Executing test [1]( 1 1 COmSignalSingleton ( 1 12 fhafuea ) COmExprValInt ( 123 3 32 123 1 ) )
 PASSED
Executing test [2]( 2 3 COmSignalPort ( 1 12 test 0 ) COmExprValReal ( 2 20 2 20 2 2000 1 ) 3 )
 PASSED
Ended testing ... COmStmtAssn
No. of tests/Passed
2/2
$

The shell returns 0 if no bugs are detected and all tests are correct.
                  1 if no bugs are detected and not all tests are correct.
                  2 if the test detected a bug and all tests are correct.
                  3 if the test detected a bug and at least one test is not correct.
                  10 if the input command is not correct.
                  11 if the test file couldn't be opened.

Now about the tests:
	Each line in the input test file has to be smaller then MAX_BUFF_SIZE-1 (see testDriver.h), last time I checked it was 2000, so a line has to be of maximum 1999 characters
	Any line in a test file that begins with # is considered a comment
	Every line in the test file is a test, if it's not a comment or doesn't have any non-whitespace characters
	Every test begins with '('
	Any set of characters before '(' are ignored, this way you may put a name to each test in front of it
	At the end of each test you may comment it with "//comment", if any other characters are detected at the end of the test, the test becomes invalid, even if by that time it already passed
	You will find sample tests in the testFiles directory for each of the possible tests, these file should contain help about writting each type of test, I recommend going through these files in the order of the test numbers. Also these files are default input if the -f option is not passed to the Driver.
	For better understanding how to test you should look at the header file of the classes you are testing, this way you will understand why the test is made the way it is.
	!! You should pay attention at the test syntax especially when you want to nest a test in another test, because when a test is nested sometimes the parent class is passed from the upper test, this way a parent descriptoin in the nested test is not necessary and if you write one, the test becomes INVALID.
	!!! Some tests syntaxes require values like OPTYPE or SIGNAL_TYPE, these are enum values from enum_type tables, you can look-up the value you want (ex. you want a signal to be of type reg) in the testTables.h file in this directory. You can find the value you are looking for by folowing these steps:
		1) Find the table witch contains the enum type the constructor takes (ex. ltabSignal is of EOmSignal tye)
		2) Look into the table and find the value you wish to put into the test
		3) For the value you decided to test with you should find witch place in the table it has
		4) Now put the place nomber into the field of the test witch required this value
		( Note: place may only be in the interval 0 .. tableSize-1 )
