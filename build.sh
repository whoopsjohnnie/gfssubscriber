#!/bin/bash
set -ex

# This script is the Jenkins build helper as it were. 

GIT_SHA=$(git rev-parse HEAD | cut -c 1-8)
eval $(aws ecr get-login --no-include-email --profile=ecr-user --region=us-west-2)

# 513562861795.dkr.ecr.us-west-2.amazonaws.com/gfs-subscriber
IMAGE="513562861795.dkr.ecr.us-west-2.amazonaws.com/gfs-subscriber:latest-$GIT_SHA"
LATEST_IMAGE="513562861795.dkr.ecr.us-west-2.amazonaws.com/gfs-subscriber:latest"
docker build -t $IMAGE -f Dockerfile .
docker push $IMAGE
docker tag $IMAGE $LATEST_IMAGE
docker push $LATEST_IMAGE

