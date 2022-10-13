#!/bin/bash
curl -XGET 'http://10.12.21.103:9200/canvas/_search' -d '
{
  "query":{
  "filtered":{
  "query":{ 
      "range" : { "id" : {"gte" : 1}},
      "match" : { "member_site_id" : 1}
      },
  "filter":{
    "or":[
        {"match_phrase":{"response_text":"kill myself"}}
    ]
    }
  }
  },
  "highlight" : {
        "fields" : { 
            "response_text":{
        "pre_tags": [
          "===>"
        ],
        "post_tags": [
          "<==="
        ],
        "fragment_size": 200,
        "number_of_fragments": 100
       }
       }
       }
}'
