#!/usr/bin/env bash

echo "Add user '$USER' to the group 'docker' and setup docker to start on boot."

sudo groupadd docker -f
sudo usermod -aG docker $USER
sudo service docker start
newgrp docker

