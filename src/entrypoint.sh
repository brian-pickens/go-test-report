#!/bin/sh -l

echo -e "---------------\nRunning Action\n---------------\n"

cd /github/workspace
go env -w GO111MODULE="$INPUT_GO111MODULE"
gotestsum --junitfile TEST-RESULTS.xml --jsonfile TEST-RESULTS.json $INPUT_PACKAGES
junit_report=$(cat TEST-RESULTS.xml)
json_report=$(jq -s '.' TEST-RESULTS.json)
markdown_report=$(junit2md TEST-RESULTS.xml)

echo "junit-report<<EOF"$'\n'"$junit_report"$'\n'EOF >> $GITHUB_ENV
echo "json-report<<EOF"$'\n'"$json_report"$'\n'EOF >> $GITHUB_ENV
echo "markdown-report<<EOF"$'\n'"$markdown_report"$'\n'EOF >> $GITHUB_ENV

# Output junit report to debugging
while read -r line;
do
    echo "::debug::${line}"
done <<< $junit_report

# Output json report to debugging
while read -r line;
do
    echo "::debug::${line}"
done <<< $json_report

# Output markdown report to debugging
while read -r line;
do
    echo "::debug::${line}"
done <<< $markdown_report

failed_tests=$(jq 'select(.Action | contains("fail"))' << $json_report)
echo "::debug::failed_tests:${failed_tests}"

echo -e "\n---------------\nAction complete\n---------------"

if [ -z ${failed_tests} ]; then
    exit 1;
fi;

exit 0;