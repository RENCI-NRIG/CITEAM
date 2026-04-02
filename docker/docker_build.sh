#!/usr/bin/env bash
set -e

docker build -f Dockerfile -t pegasus/citeams-tutorial:latest .
