#!/bin/bash
# Script to Create a Container for LAMP, using Docker

# 1. Download git repository
git clone https://github.com/robertoarcomano/DockerLemp.git /tmp/DockerLemp
cd /tmp/DockerLemp

# 2. Download Dockerfile and create image
docker build -t dockerlemp .

# 3. Create the container from the image
docker create -p 81:80 --name "dockerlemp" dockerlemp

# 4. Start the container
docker start dockerlemp

# 5. Delete supervisor.conf /tmp/Dockerfile
cd 
rm -rf /tmp/DockerLemp
