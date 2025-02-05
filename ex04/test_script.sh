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
cc -Wall -Wextra -Werror -o ft_convert_base main.c ft_convert_base.c ft_convert_base2.c
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
longest_test="$> ./ft_convert_base \"  ---+--+1234ab567\" \"0123456789\" \"0123456789\""
# Add some padding for better visuals and generate the separator
separator=$(generate_separator $((${#longest_test} + 2)))

# Function to run a test and check the result
run_test() {
	local number=$1
	local base_from=$2
	local base_to=$3
	local expected=$4

	echo "$separator"
	echo "$> ./ft_convert_base \"$number\" \"$base_from\" \"$base_to\""

	output=$(./ft_convert_base "$number" "$base_from" "$base_to")

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

# Tests with valid inputs
run_test "42" "0123456789" "0123456789" "42" || all_tests_passed=false
run_test "101010" "01" "0123456789" "42" || all_tests_passed=false
run_test "2A" "0123456789ABCDEF" "0123456789" "42" || all_tests_passed=false
run_test "vn" "poneyvif" "0123456789" "42" || all_tests_passed=false
run_test "-42" "0123456789" "0123456789" "-42" || all_tests_passed=false
run_test "  ---+--+1234ab567" "0123456789" "0123456789" "-1234" || all_tests_passed=false
run_test "-2147483648" "0123456789" "01" "-10000000000000000000000000000000" || all_tests_passed=false
run_test "101010" "01" "0123456789ABCDEF" "2A" || all_tests_passed=false
run_test "2A" "0123456789ABCDEF" "01" "101010" || all_tests_passed=false
run_test "vn" "poneyvif" "01" "101010" || all_tests_passed=false
run_test "101010" "01" "poneyvif" "vn" || all_tests_passed=false

# Tests with invalid inputs
run_test "42" "" "0123456789" "Error: Invalid base or conversion failed." || all_tests_passed=false
run_test "42" "0" "0123456789" "Error: Invalid base or conversion failed." || all_tests_passed=false
run_test "42" "01234567890" "0123456789" "Error: Invalid base or conversion failed." || all_tests_passed=false
run_test "42" "01234+6789" "0123456789" "Error: Invalid base or conversion failed." || all_tests_passed=false
run_test "42" "01234-6789" "0123456789" "Error: Invalid base or conversion failed." || all_tests_passed=false

# Final result
echo "$separator"
if $all_tests_passed; then
	echo -e "${GREEN}All tests passed: OK${NC}"
else
	echo -e "${RED}Some tests failed: KO${NC}"
fi
echo "$separator"

# Clean up compiled files
rm ft_convert_base