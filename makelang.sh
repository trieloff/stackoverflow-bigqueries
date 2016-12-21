#!/bin/sh

for i in $@
do
pbpaste | sed -e "s/XLANGX/$i/g"
done