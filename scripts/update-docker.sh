#!/bin/sh
set -e -u

CONTAINER=neoterm-package-builder
IMAGE=ghcr.io/juic3b0x/package-builder

docker pull $IMAGE

LATEST=$(docker inspect --format "{{.Id}}" $IMAGE)
RUNNING=$(docker inspect --format "{{.Image}}" $CONTAINER)

if [ $LATEST = $RUNNING ]; then
	echo "Image '$IMAGE' used in the container '$CONTAINER' is already up to date"
else
	echo "Image '$IMAGE' used in the container '$CONTAINER' has been updated - removing the outdated container"
	docker stop $CONTAINER
	docker rm -f $CONTAINER
fi

