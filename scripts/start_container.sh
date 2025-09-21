#!/bin/bash
set -e

docker stop memory-monster

docker rm memory-monster

# Pull the Docker image from Docker Hub
docker pull amaldeep98/memory-monster:latest

# Run the Docker image as a container
docker run -d --name memory-monster -p 8088:8088 amaldeep98/memory-monster:latest
