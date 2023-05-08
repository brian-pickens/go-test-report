#!/bin/bash -l

echo -e "---------------\nRunning Action\n---------------\n"

cd /github/workspace
go env -w GO111MODULE="$INPUT_GO111MODULE"
gotestsum --junitfile TEST-RESULTS.xml --jsonfile TEST-RESULTS.json $INPUT_PACKAGES
json_report=$(jq -sc '.' TEST-RESULTS.json)
junit_report=$(cat TEST-RESULTS.xml)
markdown_report=$(junit2md TEST-RESULTS.xml)

echo "json-report=${json_report}" >> $GITHUB_OUTPUT
echo "junit-report<<EOF"$'\n'"${junit_report}"$'\n'EOF >> $GITHUB_OUTPUT
echo "markdown-report<<EOF"$'\n'"${markdown_report}"$'\n'EOF >> $GITHUB_OUTPUT

# Set Summary
echo "markdown-report<<EOF"$'\n'"${markdown_report}"$'\n'EOF >> $GITHUB_STEP_SUMMARY

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

failed_tests=$(jq -c '.[] | select(.Action | contains("fail"))' <<< $json_report)
echo "::debug::failed_tests:${failed_tests}"

echo -e "\n---------------\nAction complete\n---------------"

if [ -z "$failed_tests" ]; then
    exit 1;
fi;

exit 0;