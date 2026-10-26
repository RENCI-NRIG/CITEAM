#!/usr/bin/env bash

set -e

docker run --volume ..:/home/citeams/notebooks --volume ../../CITEAM-code/notebooks:/home/citeams/diffraction  --rm -p 9999:8888 pegasus/citeams-tutorial:latest
