#!/bin/bash
set -e

# Pull the Docker image from Docker Hub
docker pull amaldeep98/memory-monster:latest

# Run the Docker image as a container
run run -d -p 8088:8088 amaldeep98/memory-monster:latest