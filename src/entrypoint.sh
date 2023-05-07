#!/bin/sh -l

echo -e "---------------\nRunning Action\n---------------\n"

cd /github/workspace
gotestsum --junitfile TEST-RESULTS.xml --jsonfile TEST-RESULTS.json $modules
echo "junit-report=$(cat TEST-RESULTS.xml)" >> $GITHUB_OUTPUT
echo "json-report=$(cat TEST-RESULTS.json)" >> $GITHUB_OUTPUT
echo "markdown-report=$(junit2md TEST-RESULTS.xml)" >> $GITHUB_OUTPUT

echo -e "\n---------------\nAction complete\n---------------"