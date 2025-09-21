#!/bin/bash
set +e  # disable exit on error for this script

CONTAINER_NAME=memory-monster

# Check if container exists (running or stopped)
CONTAINER_ID=$(docker ps -aq -f name=^${CONTAINER_NAME}$ | tr -d '[:space:]')

if [ -n "$CONTAINER_ID" ]; then
    echo "Stopping container $CONTAINER_NAME..."
    docker stop "$CONTAINER_ID"
    echo "Removing container $CONTAINER_NAME..."
    docker rm "$CONTAINER_ID"
else
    echo "No container named $CONTAINER_NAME found. Nothing to stop."
fi

exit 0  # ensure script exits successfully
