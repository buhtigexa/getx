# on the host's bash

# Creates the cluster and provision it with the images and load balancer


cd getx

git clone https://github.com/buhtigexa/nlpws.git
git clone https://github.com/buhtigexa/ocrws.git
cd nlpws
sh build.sh

cd ..
cd ocrws
sh build.sh

cd ..


sh delete_swarm.sh

docker-machine create -d virtualbox manager & docker-machine create -d virtualbox worker1 & docker-machine create -d virtualbox worker2 

docker-machine ssh manager "docker swarm init \
    --listen-addr $(docker-machine ip manager) \
    --advertise-addr $(docker-machine ip manager)"

export worker_token=$(docker-machine ssh manager "docker swarm \
join-token worker -q")

docker-machine ssh worker1 "docker swarm join \
    --token=${worker_token} \
    --listen-addr $(docker-machine ip worker1) \
    --advertise-addr $(docker-machine ip worker1) \
    $(docker-machine ip manager)"

docker-machine ssh worker2 "docker swarm join \
    --token=${worker_token} \
    --listen-addr $(docker-machine ip worker2) \
    --advertise-addr $(docker-machine ip worker2) \
    $(docker-machine ip manager)"



docker-machine ssh manager "docker network create --driver=overlay traefik-net"

docker-machine ssh manager "docker service create \
    --name traefik \
    --constraint=node.role==manager \
    --publish 80:80 --publish 8080:8080 \
    --mount type=bind,source=/var/run/docker.sock,target=/var/run/docker.sock \
    --network traefik-net \
    traefik \
    --docker \
    --docker.swarmmode \
    --docker.domain=traefik \
    --docker.watch \
    --web"



docker-machine ssh manager "docker service create \
--name nlpws \
--network traefik-net \
--label traefik.port=8080 \
--publish 33100:8080 \
--label traefik.backend=nlpws \
--label traefik.frontend.rule=Host:cloud.nlp.docker.localhost \
dockerexa/nlpws:v1"

sleep 1h

docker-machine ssh manager "docker service create \
--name ocrws \
--mount type=bind,source=/tmp,target=/tmp/ \
--network traefik-net \
--label traefik.port=8080 \
--publish 33000:8080 \
--label traefik.backend=ocrws \
--label traefik.frontend.rule=Host:cloud.ocr.docker.localhost \
 dockerexa/ocrws:v1"


#sed -i "3i 192.168.99.100" www.getx.com

clear

docker-machine ssh manager "docker service scale ocrws=2"
#docker-machine ssh manager "docker service scale nlpws=2"
docker-machine ls
docker-machine ssh manager "docker service ls"
docker-machine ssh manager "docker node ps"
docker-machine ssh manager "docker node ps worker1"
docker-machine ssh manager "docker node ps worker2"




