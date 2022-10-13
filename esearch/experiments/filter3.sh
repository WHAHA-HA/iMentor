#!/bin/bash
curl -XGET 'http://10.12.21.103:9200/portfolio/_search' -d '
{
  "query":{
  "filtered":{
  "filter":{
    "and":[
      {"term" : { "member_site_id" : 1}},
      {"term" : { "partner_site_id" : 1629}}
    ],
    "or":[
    {"term": {"reflection_text": "suicide"}},
    {"term": {"reflection_text": "rape"}},
    {"match_phrase": {"reflection_text": "kill them"}},
    {"match_phrase": {"reflection_text": "kill myself"}},
    {"match_phrase": {"reflection_text": "kill everyone"}},
    {"match_phrase": {"reflection_text": "kill them"}},
    {"match_phrase": {"reflection_text": "hurt myself"}}
    ]
    },
  "query":{ 
      "range" : {"date_indexed": {"gt": 1, "lte": 1460693460}}
      }
  },
  "highlight" : {
        "fields" : { 
            "reflection_text":{
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
}"
