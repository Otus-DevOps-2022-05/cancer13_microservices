#!/bin/bash
docker-machine rm docker-host
yc compute instance delete docker-host
