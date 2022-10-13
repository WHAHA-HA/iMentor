#!/bin/bash
curl -XGET 'http://10.12.21.103:9200/canvas/_search' -d '
{
  "query":{ 
      "range" : { "id" : {"gte" : 1}}
  },
  "filter":{
    "or":[
        {"term":{"response_text":"fuck"}}
    ]
  },
  "highlight" : { 
        "fields" : { 
            "response_text":{
               "highlight_query": {
                    "query_string": { "query": "fuck OR shit" }
                    },
               "number_of_fragments":10000
               }
           }
       }
}'
