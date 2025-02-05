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
cc -Wall -Wextra -Werror -o ft_ultimate_range ft_ultimate_range.c main.c
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
longest_test="$> ./ft_ultimate_range -2147483648 2147483647"
# Add some padding for better visuals and generate the separator
separator=$(generate_separator $((${#longest_test} + 2)))

# Function to run a test and check the result
run_test() {
	local min=$1
	local max=$2
	local expected=$3

	echo "$separator"
	echo "$> ./ft_ultimate_range $min $max"

	output=$(./ft_ultimate_range "$min" "$max")

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

# Test: Normal range
run_test 1 5 "1 2 3 4" || all_tests_passed=false
# Test: Empty range (min == max)
run_test 5 5 "Range from 5 to 5 is NULL" || all_tests_passed=false
# Test: Negative range
run_test -3 2 "-3 -2 -1 0 1" || all_tests_passed=false
# Test: Single element range
run_test 0 1 "0" || all_tests_passed=false
# Test: Large range
run_test 1000 1005 "1000 1001 1002 1003 1004" || all_tests_passed=false
# Test: Reverse range (min > max)
run_test 5 1 "Range from 5 to 1 is NULL" || all_tests_passed=false
# Test: Large negative range
run_test -5 -1 "-5 -4 -3 -2" || all_tests_passed=false
# Test: Integer overflow
run_test -2147483648 2147483647 "Memory allocation failed" || all_tests_passed=false

# Final result
echo "$separator"
if $all_tests_passed; then
	echo -e "${GREEN}All tests passed: OK${NC}"
else
	echo -e "${RED}Some tests failed: KO${NC}"
fi
echo "$separator"

# Clean up compiled files
rm ft_ultimate_range