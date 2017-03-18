#!/bin/bash

#stops the cluster and all the containers in the system, also remove images

docker-machine stop manager
docker-machine stop worker1
docker-machine stop worker2
docker-machine stop worker3

sudo docker stop $(docker ps -aq) && docker rm $(docker ps -aq)
sudo docker ps

