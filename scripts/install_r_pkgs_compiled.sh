#!/bin/bash

set -e
set -x

## Install R packages that need compilation
install2.r --error --skipinstalled \
  bibtex \
  brms \
  fasterize \
  fst \
  greta \
  hexbin \
  h2o \
  jqr \
  officer \
  packrat \
  prioritizr \
  profmem \
  profvis \
  RcppArmadillo \
  RcppGSL \
  RcppZiggurat \
  reticulate \
  Rglpk \
  rjags \
  RJSONIO \
  Rsymphony \
  runjags \
  rstanarm \
  rvg \
  shinystan \
  slam \
  tidymodels \
  vegan \
  xgboost \
  zip



