#!/bin/bash
curl -XGET 'http://10.12.21.103:9200/canvas/_search' -d '
{
 "query": {"filtered": {
    "query": {"range": {"date_indexed": {"gt": 1, "lte": 1460693460}}},
    "filter": {"and": [{"term": {"member_site_id": 1}}],
                                   "or": [{"term": {"response_text": "suicide"}},
                                          {"term": {"response_text": "rape"}},
                                          {"match_phrase": {"response_text": "kill them"}},
                                          {"match_phrase": {"response_text": "kill myself"}},
                                          {"match_phrase": {"response_text": "kill everyone"}},
                                          {"match_phrase": {"response_text": "kill them"}},
                                          {"match_phrase": {"response_text": "hurt myself"}}]},
    }},
 "highlight": {"fields": {"response_text": {"fragment_size": 200,
                                              "number_of_fragments": 100,
                                              "post_tags": ["<==="],
                                              "pre_tags": ["===>"]}}}
}

'
