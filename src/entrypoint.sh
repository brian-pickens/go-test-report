#!/bin/bash -l

echo -e "---------------\nRunning Action\n---------------\n"

# Setup workspace
cd /github/workspace
go env -w GO111MODULE="$INPUT_GO111MODULE"

# Run tests
gotestsum --junitfile TEST-RESULTS.xml --jsonfile TEST-RESULTS.json $INPUT_PACKAGES

# Generate Reports
json_report=$(jq -sc '.' TEST-RESULTS.json)
junit_report=$(cat TEST-RESULTS.xml)
markdown_report=$(junit2md TEST-RESULTS.xml)

# Set Outputs
echo "json-report=${json_report}" >> $GITHUB_OUTPUT
echo "junit-report<<EOF"$'\n'"${junit_report}"$'\n'EOF >> $GITHUB_OUTPUT
echo "markdown-report<<EOF"$'\n'"${markdown_report}"$'\n'EOF >> $GITHUB_OUTPUT

# Set Summary
if [ "$INPUT_SUMMARY" = "true" ]; then
    echo "${markdown_report}" >> $GITHUB_STEP_SUMMARY
fi;

# Output json report to debugging
echo "::debug::json report"
echo "::debug::$json_report"

# Output junit report to debugging
echo "::debug::junit report"
while read -r line;
do
    echo "::debug::${line}"
done <<< $junit_report

# Output markdown report to debugging
while read -r line;
do
    echo "::debug::${line}"
done <<< $markdown_report

# Check for failed tests
failed_tests=$(jq -c '.[] | select(.Action | contains("fail"))' <<< $json_report)
echo "::debug::failed_tests:${failed_tests}"

echo -e "\n---------------\nAction complete\n---------------"

# Exit successfully if reports-only mode
if [ "$INPUT_REPORTS_ONLY" = "true" ]; then
    exit 0;
fi;

# Fail the action if any tests failed
if [ ! -z "$failed_tests" ]; then
    exit 1;
fi;

exit 0;