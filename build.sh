#!/bin/bash

set -e 
set -x

for tag in apt rstan inla rpkg server gpu
do
  image=ecohealthalliance/reservoir:$tag
  docker pull $image || true
  docker build -q -f Dockerfile.$tag --cache-from $image -t $image .
done