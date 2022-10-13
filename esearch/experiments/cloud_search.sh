#!/bin/bash

curl -XGET 'localhost:9200/canvas/_search' -d '
{
  "query":{
      "match_all":{}
    },
  "aggs":{
    "tagcloud":{
        "terms":{
            "field":"response_text"
            }
        }
    }
}'
