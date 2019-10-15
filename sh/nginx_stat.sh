#!/bin/bash

RespStr=$(/usr/bin/curl --max-time 20 --no-keepalive --silent "https://status.jifenzhi.com/status")
[ $? != 0 ] && echo 0 && exit 1

(cat <<EOF
$RespStr
EOF
) | awk '/^Active connections/ {active = int($NF)}
/^ *[0-9]+ *[0-9]+ *[0-9]+/ {accepts = int($1); handled = int($2); requests = int($3); request_time = int($4)}
/^Reading:/ {reading = int($2); writing = int($4); waiting = int($NF)}
END {
print "- nginx.active", active;
print "- nginx.accepts", accepts;
print "- nginx.handled", handled;
print "- nginx.requests", requests;
print "- nginx.request_time", request_time;
print "- nginx.reading", reading;
print "- nginx.writing", writing;
print "- nginx.waiting", waiting;
print "- nginx.dropped", accepts-handled;
}' |grep $1 | awk '{print $3}'
exit 0
