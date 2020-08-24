#!/bin/bash

set -e
set -x

## Install R packages that need compilation
## Install the rest of the R packages
install2.r --error --skipinstalled \
     assertr \
     bayesplot \
     caret \
     cowplot \
     doMC \
     doParallel \
     here \
     keras \
     knitcitations \
     loo \
     optimx \
     patchwork \
     plotly \
     renv \
     rasterVis \
     rgrass7 \
     RhpcBLASctl \
     ROI \
     ROI.plugin.glpk \
     Rsymphony ROI.plugin.symphony

## Install GitHub R Packages
installGithub.r \
    s-u/unixtools

rm -rf /tmp/downloaded_packages/ /tmp/*.rds /root/tmp/downloaded_packages
