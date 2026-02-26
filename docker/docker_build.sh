#!/usr/bin/env bash
set -e

docker build -f Dockerfile -t citeams/training:latest .
