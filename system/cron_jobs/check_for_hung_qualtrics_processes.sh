#!/bin/bash

# This finds a hung "check_survey_status" process if it is hung for > 1 day.

# Older processes have a month and day, and don't match this pattern.
re_timestamp='^[0-9]+([:][0-9]+)?$'

for timestamp in `ps awux | grep check_survey_status | grep -v grep | awk '{print $9}'`
do
    if ! [[ $timestamp =~ $re_timestamp ]]
    then
        for i in `ps awux | grep check_survey_status | grep -v grep | awk '{print $2}'`
        do
            echo "Need to kill qualtrics process ${i}, looks hung."
            kill -9 $i
        done    
    else
        #echo "All is well: ${timestamp}"
        : # no-op
    fi
done

for timestamp in `ps awux | grep check_for_qualtrics_dups | grep -v grep | awk '{print $9}'`
do
    if ! [[ $timestamp =~ $re_timestamp ]]
    then
        for i in `ps awux | grep check_for_qualtrics_dups | grep -v grep | awk '{print $2}'`
        do
            echo "Need to kill qualtrics process ${i}, looks hung."
            kill -9 $i
        done    
    else
        #echo "All is well: ${timestamp}"
        : # no-op
    fi
done
