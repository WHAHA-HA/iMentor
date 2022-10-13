#!/usr/bin/env bash

for i in */grunt; do cd $i; npm install; grunt production; cd ../..; echo "Did $i..................."; done
