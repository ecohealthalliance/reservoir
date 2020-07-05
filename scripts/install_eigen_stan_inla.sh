#!/bin/bash

set -e
set -x

## Install R packages that need compilation
install2.r --error --skipinstalled \
  RcppEigen \
  rstan
install2.r --error --skipinstalled \
  --repos "https://inla.r-inla-download.org/R/stable" \
  INLA 