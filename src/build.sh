#!/bin/sh -l

echo -e "----------------\Setting Up Action\n----------------\n"
mkdir -p /build
wget https://github.com/gotestyourself/gotestsum/archive/refs/tags/v1.10.0.zip -O gotestsum-v1.10.0.zip
unzip -q gotestsum-v1.10.0.zip; mv gotestsum-1.10.0/* /build
cd /build
go build -o /usr/local/bin/gotestsum
chmod +x /usr/local/bin/gotestsum