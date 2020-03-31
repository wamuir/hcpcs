#!/usr/bin/env bash

# Need to parse title from yaml header as first-level header/h1 in output md

book='---
title: Health Care Procedure Coding System
author: William Muir
date: March 31st, 2020
output:
  rmarkdown::html_document:
    self_contained: true
    css: ["_book.css"]
    highlight: null
    mathjax: null
    theme: yeti
    toc: true
    toc_float: true
    collapsed: false
    toc_depth: 2
---
'

for f in about.md groups/*.md; do
    chapter=$(perl -ne 'if ($i > 1) { print } else { /^---/ && $i++ }' $f)
    book+=${chapter}
done

book+='
<div class="tocify-extend-page" data-unique="tocify-extend-page" style="height: 0;"></div>
'
echo -e "${book}" > _book.Rmd


css='
tbody > tr:nth-of-type(odd) {
  background-color: #f9f9f9;
}
tbody > tr:hover {
  background-color: #f5f5f5;
}
'

echo -e "${css}" > _book.css


Rscript -e 'rmarkdown::render("_book.Rmd", output_file="book.html")'
