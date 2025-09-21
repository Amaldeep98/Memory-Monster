#!/bin/bash
set -e

PORT=8088

# Find container using the port
CONTAINER_ID=$(docker ps -q --filter "publish=$PORT")

if [ -n "$CONTAINER_ID" ]; then
    echo "Stopping container(s) using port $PORT..."
    docker stop $CONTAINER_ID
    echo "Removing container(s)..."
    docker rm $CONTAINER_ID
else
    echo "No container is using port $PORT."
fi
