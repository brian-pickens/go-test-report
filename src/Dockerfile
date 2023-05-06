

FROM golang:1.20-alpine as Action

COPY entrypoint.sh /entrypoint.sh

WORKDIR /tmp
RUN wget https://github.com/gotestyourself/gotestsum/releases/download/v1.10.0/gotestsum_1.10.0_linux_amd64.tar.gz -O gotestsum \
 && mv gotestsum /usr/local/bin/gotestsum \
 && chmod +x /usr/local/bin/gotestsum

ENTRYPOINT ["/entrypoint.sh"]