yc compute instance create \
  --name docker-host \
  --zone ru-central1-a \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1804-lts,size=15 \
  --ssh-key ~/.ssh/id_rsa_appuser.pub
	
docker-machine create \
  --driver generic \
  --generic-ip-address=51.250.86.225 \
  --generic-ssh-user yc-user \
  --generic-ssh-key ~/.ssh/id_rsa_appuser \
  docker-host
  
eval $(docker-machine env docker-host)

docker-machine rm docker-host
yc compute instance delete docker-host