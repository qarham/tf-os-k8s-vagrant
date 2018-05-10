#!/bin/bash -eux

for i in `grep -i image: contrail.yaml | cut -f2- -d: | awk '{print substr($1,2,length($1)-2)}'`; do docker pull $i ; done