#!/bin/bash

docker-machine stop manager
docker-machine stop worker1
docker-machine stop worker2
docker-machine stop worker3

sudo docker stop $(docker ps -aq) && docker rm $(docker ps -aq)
sudo docker ps

