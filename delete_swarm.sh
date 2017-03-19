 
 #!/bin/bash
 

 docker-machine stop worker1
 docker-machine stop worker2
 docker-machine stop manager

 docker-machine rm -y worker1
 docker-machine rm -y worker2
 docker-machine rm -y manager

 