#!/bin/bash
curl -XGET 'http://10.12.21.103:9200/canvas/_search' -d '
{
  "query":{
  "constant_score":{
  "filter":{
  "bool":{
    "should":[
        {"term":{"response_text":"fuck"}},
        {"term":{"response_text":"shit"}}
    ],
    "must":[
      {"term" : { "member_site_id" : 1}},
      {"term" : { "partner_site_id" : 1629}},
      {"range" : { "id" : {"gte" : 1}}}
    ]
    }
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
