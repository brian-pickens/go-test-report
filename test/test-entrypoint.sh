#!/bin/sh -l

# Simulate setting input environment variables
export INPUT_PACKAGES="./..."
export INPUT_SUMMARY="true"
export INPUT_REPORT_ONLY="false"
export INPUT_GO111MODULE="auto"
export GITHUB_OUTPUT="/github_output.txt"

# Run action entrypoint
/entrypoint.sh

# cat $GITHUB_OUTPUT