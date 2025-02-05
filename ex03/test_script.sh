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
cc -Wall -Wextra -Werror -o ft_strjoin ft_strjoin.c main.c
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
longest_test="$> ./ft_strjoin \",\" \"This is a very long string\" \"to test the ft_strjoin function\""
# Add some padding for better visuals and generate the separator
separator=$(generate_separator $((${#longest_test} + 2)))

# Function to format arguments with quotes
format_args() {
	local args=("$@")
	local formatted_args=""
	for arg in "${args[@]}"; do
		formatted_args="$formatted_args \"$arg\""
	done
	# Remove the leading space
	formatted_args=$(echo $formatted_args | sed 's/^ //')
	echo "$formatted_args"
}

# Function to run a test and check the result
run_test() {
	local sep=$1
	shift
	local expected=$1
	shift
	local args=("$@")

	echo "$separator"
	echo "$> ./ft_strjoin \"$sep\" $(format_args "${args[@]}")"

	output=$(./ft_strjoin "$sep" "${args[@]}")

	if [ "$output" == "$expected" ]; then
		echo -e "${GREEN}Test passed${NC}"
		#echo -e "-> Actual output:\n\"$output\""
		return 0
	else
		echo -e "${RED}Test failed${NC}"
		echo -e "-> Expected output:\n\"$expected\""
		echo -e "-> Actual output:\n\"$output\""
		return 1
	fi
}

# Run tests
all_tests_passed=true

# Test: Normal strings
run_test "," "Hello,World" "Hello" "World" || all_tests_passed=false
# Test: Empty separator
run_test "" "HelloWorld" "Hello" "World" || all_tests_passed=false
# Test: Single string
run_test "," "Hello" "Hello" || all_tests_passed=false
# Test: No strings (size == 0)
run_test "," "" || all_tests_passed=false
# Test: Strings with spaces
run_test " " "Hello World" "Hello" "World" || all_tests_passed=false
# Test: Strings with special characters
run_test "-" "!@#-$%^" "!@#" "$%^" || all_tests_passed=false
# Test: Long strings
run_test "," "This is a very long string,to test the ft_strjoin function" "This is a very long string" "to test the ft_strjoin function" || all_tests_passed=false
# Test: Strings with newlines
run_test "\n" "Line1\nLine2" "Line1" "Line2" || all_tests_passed=false
# Test: Empty string as argument
run_test "," "Hello,,World" "Hello" "" "World" || all_tests_passed=false
# Test: Multiple strings
run_test "," "One,Two,Three,Four" "One" "Two" "Three" "Four" || all_tests_passed=false

# Final result
echo "$separator"
if $all_tests_passed; then
	echo -e "${GREEN}All tests passed: OK${NC}"
else
	echo -e "${RED}Some tests failed: KO${NC}"
fi
echo "$separator"

# Clean up compiled files
rm ft_strjoin