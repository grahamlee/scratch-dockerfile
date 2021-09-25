MAKEFILE := $(abspath $(lastword $(MAKEFILE_LIST)))
PROJECT := $(dir $(MAKEFILE))
BIN := $(PROJECT)bin
OUT := $(BIN)/ecr
SCRIPT := $(PROJECT)update.sh

CONTAINER := scratch:latest
TAG := grahamlee/scratch:latest

default: update

update:
	sh ${SCRIPT}

build:
	docker build -t ${TAG} .
	docker push ${TAG}
