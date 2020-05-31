#!/bin/bash
# Script to Create a Container for LAMP, using Docker

# 1. Download git repository
rm -rf /tmp/wordpress
git clone https://github.com/robertoarcomano/wordpress.git /tmp/wordpress

# 2. Download Dockerfile and create image
docker rmi -f robertoarcomano/wordpress
cp -a wordpress* /tmp/wordpress/
docker build -t robertoarcomano/wordpress /tmp/wordpress

# 3. Create the container from the image
docker rm -f wordpress
docker create -p 81:80 --name "wordpress" robertoarcomano/wordpress

# 4. Start the container
docker start wordpress

