FROM golang:1.20-alpine as Action
RUN apk update && apk add jq bash

COPY entrypoint.sh /entrypoint.sh

RUN wget https://github.com/gotestyourself/gotestsum/archive/refs/tags/v1.10.0.zip -O gotestsum-v1.10.0.zip \
    && mkdir /build \
    && unzip -q gotestsum-v1.10.0.zip; mv gotestsum-1.10.0/* /build \
    && cd /build \
    && go build -o /usr/local/bin/gotestsum \
    && chmod +x /usr/local/bin/gotestsum

RUN wget https://github.com/cicdguy/junit2md/releases/download/v0.1.0/junit2md_0.1.0_linux-amd64 -O /usr/local/bin/junit2md \
    && chmod +x /usr/local/bin/junit2md

WORKDIR /github/workspace
ENTRYPOINT ["/entrypoint.sh"]