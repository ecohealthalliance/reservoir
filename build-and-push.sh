#!/bin/bash

set -e
set -x

for tag in apt rcppeigen rstan inla rpkg server gpu
do
  image=ecohealthalliance/reservoir:$tag
  docker build -q -f Dockerfile.$tag --cache-from $image -t $image .
  docker push $image
done