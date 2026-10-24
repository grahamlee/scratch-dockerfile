MAKEFILE := $(abspath $(lastword $(MAKEFILE_LIST)))
PROJECT := $(dir $(MAKEFILE))
BIN := $(PROJECT)bin
OUT := $(BIN)/ecr
SCRIPT := $(PROJECT)update.sh

CONTAINER := scratch:latest
TAG := docker.io/grahamlee/scratch:latest
DOCKERHUB_USER := grahamlee
DOCKERHUB_TOKEN_FILE := $(HOME)/.config/dockerhub/token

default: update

update:
	sh ${SCRIPT}

login:
	podman login docker.io -u ${DOCKERHUB_USER} --password-stdin < ${DOCKERHUB_TOKEN_FILE}

build: login
	podman build --platform linux/amd64 -t ${TAG} .
	podman push ${TAG}
