#!/bin/bash

set -e
set -x

for tag in apt rcppeigen rstan inla rpkg server gpu
do
  image=ecohealthalliance/reservoir:$tag
  docker push $image
done