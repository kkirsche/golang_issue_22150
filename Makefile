BINARY=golang_issue_22150
GOARCH=amd64
HASH=$(shell git rev-parse HEAD)
BUILDDATE=$(shell date -u '+%Y-%m-%dT%k:%M:%SZ')
GOVERSION=$(shell go version | sed -e 's/ /|^|/g')
VERSION=1.0.0
LDFLAGS=-ldflags "-s -X github.com/kkirsche/$(BINARY)/cmd.BuildHash=$(HASH) -X github.com/kkirsche/$(BINARY)/cmd.BuildTime=$(BUILDDATE) -X github.com/kkirsche/$(BINARY)/cmd.BuildVersion=$(VERSION) -X github.com/kkirsche/$(BINARY)/cmd.BuildGoVersion=$(GOVERSION)"

lint:
	golint ./...

vet:
	go vet ./...

clean:
	rm -rf bin

install:
	go install -race -v

binary-depends:
	mkdir -p bin

# Builds
darwin-build: vet lint binary-depends
	env GOOS=darwin GOARCH=$(GOARCH) go build $(LDFLAGS) -v -o bin/$(BINARY).release.$(VERSION).$(GOARCH).darwin

dragonfly-build: vet lint binary-depends
	env GOOS=dragonfly GOARCH=$(GOARCH) go build $(LDFLAGS) -v -o bin/$(BINARY).release.$(VERSION).$(GOARCH).dragonfly

freebsd-build: vet lint binary-depends
	env GOOS=freebsd GOARCH=$(GOARCH) go build $(LDFLAGS) -v -o bin/$(BINARY).release.$(VERSION).$(GOARCH).freebsd

linux-build: vet lint binary-depends
	env GOOS=linux GOARCH=$(GOARCH) go build $(LDFLAGS) -v -o bin/$(BINARY).release.$(VERSION).$(GOARCH).linux

netbsd-build: vet lint binary-depends
	env GOOS=netbsd GOARCH=$(GOARCH) go build $(LDFLAGS) -v -o bin/$(BINARY).release.$(VERSION).$(GOARCH).netbsd

openbsd-build: vet lint binary-depends
	env GOOS=openbsd GOARCH=$(GOARCH) go build $(LDFLAGS) -v -o bin/$(BINARY).release.$(VERSION).$(GOARCH).openbsd

solaris-build: vet lint binary-depends
	env GOOS=solaris GOARCH=$(GOARCH) go build $(LDFLAGS) -v -o bin/$(BINARY).release.$(VERSION).$(GOARCH).solaris

build: darwin-build dragonfly-build freebsd-build linux-build netbsd-build openbsd-build solaris-build

.PHONY: vet install binary-depends lint
