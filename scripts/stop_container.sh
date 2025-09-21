#!/bin/bash
set -e

# Find any running container (by name or all containers).
containerid=$(docker ps -q -f "name=my_app")  

if [ -n "$containerid" ]; then
    echo "Stopping and removing container $containerid"
    docker rm -f "$containerid"
else
    echo "No existing container to stop."
fi
