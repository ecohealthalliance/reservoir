# A useful script for figuring out which R packages people use on the machine
# so as to add them to the image
# 'ag -G "\.(R|Rmd)$" "library\(" /home >> libs.txt

library(stringi)
library(tidyverse)
dockr_pkgs <- installed.packages(lib.loc = .libPaths()[2:3]) %>% rownames
libs <-  read_lines("libs.txt")
used_pkgs <- libs %>% 
  stri_extract_all_regex('(?<=(library\\(|library\\(("|\')))[\\w\\.]+(?=(\\)|("|\')\\)))') %>% 
  unlist() %>% 
  {data_frame(pkg = .)} %>% 
  count(pkg) %>% 
  arrange(desc(n)) %>% 
  mutate(inst = pkg %in% dockr_pkgs) %>% 
  filter(!inst)

