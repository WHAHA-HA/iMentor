#!/usr/bin/env bash
#
# This starts a daemon! 
locust -f ./quick_read_only.py --master-host 172.30.0.64 --slave
