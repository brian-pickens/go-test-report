FROM go-test-report

COPY go.mod /github/workspace
COPY main_test.go /github/workspace
COPY main.go /github/workspace
COPY test-entrypoint.sh /test-entrypoint.sh

WORKDIR /action-workspace
ENTRYPOINT ["/test-entrypoint.sh"]