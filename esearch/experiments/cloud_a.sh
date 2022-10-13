#!/bin/bash

curl -XGET 'localhost:9200/canvas/_settings' -d '
{
  "index":{
      "settings": {
        "analysis": {
          "filter": {
            "english_stop": {
              "type":       "stop",
              "stopwords":  "_english_" 
            },
          },
          "analyzer": {
            "wordcloud_analyzer": {
              "tokenizer":  "standard",
              "filter": [
                "lowercase",
                "english_stop",
                "english_normalization",
              ]
            }
          },
          "mapping": {
            "wordcloud_mapping": {
            "type": "string",
            "analyzer": "wordcloud_analyzer",
          }
        }
    }
  }
 }
}'
