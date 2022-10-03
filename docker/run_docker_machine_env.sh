#!/bin/bash
yc compute instance create \
  --name logging \
  --hostname logging \
  --memory=4 \
  --cores=2 \
  --core-fraction=50 \
  --zone ru-central1-a \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1804-lts,size=50 \
  --ssh-key ~/.ssh/id_rsa_appuser.pub && \
EXT_IP=$(yc compute instance get --name logging --format json | jq -r '.network_interfaces[].primary_v4_address.one_to_one_nat.address') && \
echo '>>>> YC VM HOST CREATE' && \
docker-machine create \
  --driver generic \
  --generic-ip-address=$EXT_IP \
  --generic-ssh-user yc-user \
  --generic-ssh-key ~/.ssh/id_rsa_appuser \
  logging && \
echo '>>>> DOCKER-MACHIN HOST CREATE' && \
eval $(docker-machine env logging) && \
echo $(docker-machine ip logging);
