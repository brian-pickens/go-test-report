#!/bin/sh -l

echo "hello world!"
echo $(go version)

wget https://github.com/gotestyourself/gotestsum/releases/download/v1.10.0/gotestsum_1.10.0_linux_amd64.tar.gz
mv gotestsum_1.10.0_linux_amd64.tar.gz gotestsum

ls -l