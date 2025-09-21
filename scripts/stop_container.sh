#!/bin/bash
set -e

CONTAINER_NAME=memory-monster

# Get container ID (running or stopped)
CONTAINER_ID=$(docker ps -aq -f name=$CONTAINER_NAME)

if [ -n "$CONTAINER_ID" ]; then
    echo "Stopping container $CONTAINER_NAME..."
    docker stop $CONTAINER_ID || echo "Container already stopped."
    echo "Removing container $CONTAINER_NAME..."
    docker rm $CONTAINER_ID || echo "Container already removed."
else
    echo "No container named $CONTAINER_NAME found. Nothing to stop."
fi
