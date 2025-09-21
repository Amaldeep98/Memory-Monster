#!/bin/bash
set -e

docker stop memory-monster &> /dev/null


docker rm memory-monster &> /dev/null

