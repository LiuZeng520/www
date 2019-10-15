# coding=utf-8
import requests
import json

es_host = 'xx.xx.xx.xx'  # Elasticsearch访问地址


def delete_es(es_host):
    headers = {
        'Content-Type': 'application/json'
    }
    # 这里url中，用*匹配所有的索引，也可以写成logstash-* 匹配所有以logstash-开头的索引等等。
    url = 'http://{}:9200/*/_delete_by_query?conflicts=proceed'.format(es_host)

    data = {
        "query": {
            "range": {
                "@timestamp": {    # 这里我根据默认的时间来作为查询的时间字段，也可以是自定义的
                    "lt": "now-30d",    # 这里是30天，时间可自定义
                    "format": "epoch_millis"
                }
            }
        }
    }

    response = requests.post(url, headers=headers, data=json.dumps(data))
    print(response.json())

    # 删除后，需要执行forcemerge操作，手动释放磁盘空间
    url2 = 'http://{}:9200/_forcemerge?only_expunge_deletes=true&max_num_segments=1'.format(es_host)
    response = requests.post(url2)

    print(response.json())



