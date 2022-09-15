#!/bin/bash
docker-machine rm docker-gitlab
yc compute instance delete docker-gitlab
