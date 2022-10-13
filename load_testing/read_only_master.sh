#!/usr/bin/env bash
#
# This starts a daemon! 
locust -f ./quick_read_only.py --host https://nyc.imentor.org --master
