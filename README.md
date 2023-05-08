# go-test-report

This action runs your go tests and generates reports in various formats for use in your ci-cd pipeline

## Inputs

### `packages`

Go packages test. Default `"./..."`.

### `reports-only`

Generate test reports only. Does not fail action on failed tests. Default `"false"`.

### `summary`

Display test results in a step summary. Default `"true"`.

### `GO111MODULE`

Set the GO111MODULE go env variable. Default `"auto "`.

## Outputs

### `json-report`

Test results in [test2json](https://pkg.go.dev/cmd/test2json) format.

### `junit-report`

Test results in junit test format.

### `markdown-report`

Test results generated in a markdown format. Can be used to create summary or checks.

## Example usage

``` yaml
- name: brian-pickens/go-test-report
  id: test
  uses: brian-pickens/go-test-report@v1
  with:
    packages: "./..."
    reports-only: "false"
    summary: "true"
    GO111MODULE: "auto"
```