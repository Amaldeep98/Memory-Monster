#!/bin/bash
set -e

PORT=8088

# Find container using the port
docker stop memory-monster
