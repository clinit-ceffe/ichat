#!/usr/bin/env bash
sudo docker build -t ichat-app .
#sudo docker rm mynuxt
sudo docker run --name ichat-app -d -p 3000:3000 ichat-app


