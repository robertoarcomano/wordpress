#!/bin/bash
# Script to Create a Container for LAMP, using Docker

# 1. Download git repository
git clone https://github.com/robertoarcomano/wordpress.git /tmp/wordpress
cd /tmp/wordpress

# 2. Download Dockerfile and create image
docker rmi -f wordpress
docker build -t wordpress .

# 3. Create the container from the image
docker rm -f wordpress
docker create -p 81:80 --name "wordpress" wordpress

# 4. Start the container
docker start wordpress

# 5. Delete supervisor.conf /tmp/wordpress
cd 
rm -rf /tmp/wordpress
