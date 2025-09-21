#!/bin/bash
set -e

CONTAINER_NAME=memory-monster

# Get container ID (running or stopped)
CONTAINER_ID=$(docker ps -aq -f name=^${CONTAINER_NAME}$)

# Trim whitespace
CONTAINER_ID=$(echo $CONTAINER_ID | xargs)

if [ -n "$CONTAINER_ID" ]; then
    echo "Stopping container $CONTAINER_NAME..."
    docker stop "$CONTAINER_ID"
    echo "Removing container $CONTAINER_NAME..."
    docker rm "$CONTAINER_ID"
else
    echo "No container named $CONTAINER_NAME found. Nothing to stop."
fi
