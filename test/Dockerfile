FROM go-test-report

COPY --from=go-test-report /build /github/workspace
COPY test-entrypoint.sh /test-entrypoint.sh

WORKDIR /action-workspace
ENTRYPOINT ["/test-entrypoint.sh"]