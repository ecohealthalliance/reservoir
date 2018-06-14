#!/usr/bin/Rscript

pg <- xml2::read_html("https://www.rstudio.com/products/rstudio/download/preview/")
deb <- xml2::xml_attr(xml2::xml_find_all(pg, "//tr/td/a[contains(@href, 'server/debian9') and not(contains(@href, 'pro'))]"), "href")
download.file(deb, method="wget", dest="rstudio-server-preview-stretch-amd64.deb", quiet=TRUE)
