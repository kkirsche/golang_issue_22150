# golang_issue_22150

Demo of https://github.com/golang/go/issues/22150


## Building

```
make build
```

## Example

Reproducible on Darwin and Linux (potentially others also)

### 1.8.4
```
~/g/g/s/g/k/golang_issue_22150 ❯❯❯ sudo ./bin/go1.8.4/golang_issue_22150.release.1.0.0.amd64.darwin                                     ⏎
INFO[0000] Successfully created raw connection
```

### 1.9.1
```
~/g/g/s/g/k/golang_issue_22150 ❯❯❯ sudo ./bin/go1.9.1/golang_issue_22150.release.1.0.0.amd64.darwin                                     ⏎
ERRO[0000] Send() Error: Raw connection creation         error="operation not supported"
```
