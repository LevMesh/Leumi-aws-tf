#!/bin/bash

sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

sudo usermod -aG docker ubuntu && newgrp docker

docker pull adongy/hostname-docker

docker run -d -p 80:3000 adongy/hostname-docker:latest 

sudo apt-get update
sudo apt-get install awscli -y

for i in {001..015}; do head -c 1M </dev/urandom >file$i; done

for i in {001..015}; do head -c 1M </dev/urandom >test$i; done

aws s3 cp . s3://lev-leumi-bucket --recursive --exclude "rand*" --exclude ".*"

touch leumi