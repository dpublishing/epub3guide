#!/bin/sh

find samples/ ! -name 'style_template' -maxdepth 1 -mindepth 1 -type d  -print |  xargs -I '{}' epubcheck "{}" -mode exp -save
