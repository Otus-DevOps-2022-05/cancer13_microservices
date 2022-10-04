#!/bin/bash
docker-machine rm logging
yc compute instance delete logging
