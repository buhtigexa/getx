#!/bin/bash

#stops the cluster and all the containers in the system, also remove images

sh delete_swarm.sh

sudo docker stop $(docker ps -aq) && docker rm $(docker ps -aq)
sudo docker ps

