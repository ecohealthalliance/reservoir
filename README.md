# Reservoir: The EHA Data Science Container

A docker image for EHA's modeling and analytics work servers.

[![CircleCI](https://circleci.com/gh/ecohealthalliance/reservoir.svg?style=svg)](https://circleci.com/gh/ecohealthalliance/reservoir) [![license](https://img.shields.io/badge/license-GPLv2-blue.svg)](https://opensource.org/licenses/GPL-2.0)  [![](https://images.microbadger.com/badges/image/ecohealthalliance/reservoir.svg)](https://microbadger.com/images/ecohealthalliance/reservoir)  [![](https://img.shields.io/docker/pulls/ecohealthalliance/reservoir.svg)](https://hub.docker.com/r/ecohealthalliance/reservoir) [![](https://img.shields.io/docker/automated/ecohealthalliance/reservoir.svg)](https://hub.docker.com/r/ecohealthalliance/reservoir/builds)

*reservoir* is an image built for the modeling and analytics workflow at [EcoHealth Alliance](ecohealthalliance.org).  It build on top of the [rocker project](https://www.rocker-project.org/) [geospatial](https://github.com/rocker-org/geospatial) Docker image, and adds:

- A start-up workflow to load user accounts from the host server
- SSH and [mosh](https://mosh.org/) access and a suite of command-line tools
- RStudio [preview edition](https://www.rstudio.com/products/rstudio/download/preview/)
- Additional system and R libraries for geospatial (GRASS7/rgrass7) and optimization libraries (glpk/Symphony) 

See the Dockerfile for details
