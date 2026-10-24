MAKEFILE := $(abspath $(lastword $(MAKEFILE_LIST)))
PROJECT := $(dir $(MAKEFILE))
BIN := $(PROJECT)bin
OUT := $(BIN)/ecr
SCRIPT := $(PROJECT)update.sh

CONTAINER := scratch:latest
TAG := docker.io/grahamlee/scratch:latest

default: update

update:
	sh ${SCRIPT}

build:
	podman build -t ${TAG} .
	podman push ${TAG}
