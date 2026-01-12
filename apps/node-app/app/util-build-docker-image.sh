#!/bin/env bash

set -ev

docker build \
    -t local/node-app:latest \
    .

docker tag local/node-app:latest 105029661252.dkr.ecr.sa-east-1.amazonaws.com/node-app-pre-production:v1

docker push 105029661252.dkr.ecr.sa-east-1.amazonaws.com/node-app-pre-production:v1

docker tag local/node-app:latest 105029661252.dkr.ecr.sa-east-1.amazonaws.com/node-app-production:v1

docker push 105029661252.dkr.ecr.sa-east-1.amazonaws.com/node-app-production:v1
