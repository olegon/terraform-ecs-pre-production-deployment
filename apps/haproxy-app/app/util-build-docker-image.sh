#!/bin/env bash

set -ev

docker build \
    -t local/haproxy-app \
    .

docker tag local/haproxy-app:latest 105029661252.dkr.ecr.us-east-1.amazonaws.com/haproxy-app:v1

docker push 105029661252.dkr.ecr.us-east-1.amazonaws.com/haproxy-app:v1
