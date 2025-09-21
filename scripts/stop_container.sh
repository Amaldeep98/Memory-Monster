#!/bin/bash
set -e

IMAGE_NAME=amaldeep98/memory-monster:latest

# Find running containers from this image
CONTAINERS=$(docker ps -q --filter ancestor=$IMAGE_NAME)

if [ -n "$CONTAINERS" ]; then
    echo "Stopping containers running image $IMAGE_NAME..."
    docker stop $CONTAINERS
    echo "Removing containers..."
    docker rm $CONTAINERS
else
    echo "No running containers found for image $IMAGE_NAME."
fi
