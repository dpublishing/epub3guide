#!/bin/sh
java -jar ~/epubcheck-4.2.2/epubcheck.jar ./tdpf-epub3guide -mode exp -save
find samples/ ! -name 'style_template' -maxdepth 1 -mindepth 1 -type d  -print |  xargs -I '{}' java -jar ~/epubcheck-4.2.2/epubcheck.jar "{}" -mode exp -save
find practices/ ! -name 'style_template' -maxdepth 1 -mindepth 1 -type d  -print |  xargs -I '{}' java -jar ~/epubcheck-4.2.2/epubcheck.jar "{}" -mode exp -save
