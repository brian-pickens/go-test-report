# Container image that runs your code
FROM golang:1.20-alpine as Action

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]