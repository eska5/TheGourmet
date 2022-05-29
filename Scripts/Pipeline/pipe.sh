#!/bin/bash
branch=${1:-main}

printf "STOPPING CONTAINERS\n"
(cd /var/data/TheGourmet/Operations/App; sudo docker-compose down)

printf "REMOVING OLD DOCKER IMAGES\n"
yes | sudo docker system prune -a --volumes

printf "REMOVING OLD PLATFORM FILES\n"
sudo rm -rf /var/data/TheGourmet

printf "CODE CHECKOUT from branch $branch\n"
(cd /var/data; git clone -b $branch https://github.com/eska5/TheGourmet.git)

printf "PLATFORM BUILD\n"
(cd /var/data/TheGourmet/Operations/App; sudo docker-compose up)
