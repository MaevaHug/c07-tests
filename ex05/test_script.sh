#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Run norminette check
echo "Running norminette check..."
output=$(norminette -R CheckForbiddenSourceHeader 2>&1)
if [ $? -ne 0 ]; then
	echo "$output" | grep -E --color=always "Error|Warning|Norme"
	echo -e "${RED}Norminette check failed${NC}"
#	exit 1
else
	echo -e "${GREEN}Norminette check passed${NC}"
fi

# Compile the files
echo "Compiling files..."
cc -Wall -Wextra -Werror -o ft_split ft_split.c main.c
if [ $? -ne 0 ]; then
	echo -e "${RED}Compilation failed${NC}"
	exit 1
else
	echo -e "${GREEN}Compilation succeded${NC}"
fi

# Function to generate a separator line of a given length
generate_separator() {
	local length=$1
	local separator=""
	for ((i=0; i<length; i++)); do
		separator="${separator}="
	done
	echo "$separator"
}

# Assign the longest test to a variable
longest_test="$> ./ft_split \" hello , world ; this : is \" \" ,;:\""
# Add some padding for better visuals and generate the separator
separator=$(generate_separator $((${#longest_test} + 2)))

# Function to run a test and check the result
run_test() {
	local str=$1
	local charset=$2
	local expected=$3

	echo "$separator"
	echo "$> ./ft_split \"$str\" \"$charset\""

	output=$(./ft_split "$str" "$charset")

	if [ "$output" == "$expected" ]; then
		echo -e "${GREEN}Test passed${NC}"
		#echo -e "-> Actual output:\n$output"
		return 0
	else
		echo -e "${RED}Test failed${NC}"
		echo -e "-> Expected output:\n$expected"
		echo -e "-> Actual output:\n$output"
		return 1
	fi
}

# Run tests
all_tests_passed=true

# Test: Empty string and empty charset
run_test "" "" "[(null)]" || all_tests_passed=false
# Test: Empty string and non-empty charset
run_test "" "," "[(null)]" || all_tests_passed=false
# Test: Non-empty string and empty charset
run_test "hello" "" "[hello][(null)]" || all_tests_passed=false
# Test: String without separators
run_test "hello" "," "[hello][(null)]" || all_tests_passed=false
# Test: String containing only separators
run_test ",,," "," "[(null)]" || all_tests_passed=false
# Test: Separators at the beginning and end
run_test ",hello," "," "[hello][(null)]" || all_tests_passed=false
# Test: Special characters separators
run_test "hello!world@#" "!@#" "[hello][world][(null)]" || all_tests_passed=false
# Test: Multiple types of separators
run_test "hello,world;this:is" ",;:" "[hello][world][this][is][(null)]" || all_tests_passed=false
# Test: Spaces and multiple separators
run_test " hello , world ; this : is " " ,;:" "[hello][world][this][is][(null)]" || all_tests_passed=false
# Test: Consecutive separators
run_test "hello,,world" "," "[hello][world][(null)]" || all_tests_passed=false
# Test: Separators at the beginning and end with multiple separators
run_test ",,hello,world,," "," "[hello][world][(null)]" || all_tests_passed=false
# Test: Multiple different separators
run_test "hello,world;this:is" ",;:" "[hello][world][this][is][(null)]" || all_tests_passed=false
# Test: Special characters as separators
run_test "hello@world#this\$is" "@#$" "[hello][world][this][is][(null)]" || all_tests_passed=false
# Test: Multiple spaces as separators
run_test "hello   world  this  is" " " "[hello][world][this][is][(null)]" || all_tests_passed=false

# Final result
echo "$separator"
if $all_tests_passed; then
	echo -e "${GREEN}All tests passed: OK${NC}"
else
	echo -e "${RED}Some tests failed: KO${NC}"
fi
echo "$separator"

# Clean up compiled files
rm ft_split