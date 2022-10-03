#!/bin/bash
export USER_NAME='cancer13'
echo `git show --format="%h" HEAD | head -1` > build_info.txt
echo `git rev-parse --abbrev-ref HEAD` >> build_info.txt

docker build -t $USER_NAME/fluentd . && docker push $USER_NAME/fluentd
