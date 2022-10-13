#!/bin/bash
curl -XGET 'localhost:9200/canvas/_search' -d '
{
  "query":{
    "bool":{
        "must":[{"match": {"response_text":"pregnant"}}]}}         
}
'

