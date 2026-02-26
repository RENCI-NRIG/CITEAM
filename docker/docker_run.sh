#!/usr/bin/env bash

set -e

docker run --volume ..:/home/citeams/notebooks  --rm -p 9999:8888 citeams/training:latest
