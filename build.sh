#!/bin/bash

set -e 
set -x

for tag in apt rcppeigen rstan inla rpkg server gpu
do
  image=ecohealthalliance/reservoir:$tag
 # time docker pull $image > /dev/null
  time docker build -f Dockerfile.$tag --cache-from $image -t $image .
done