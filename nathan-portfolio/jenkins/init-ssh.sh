#!/bin/bash

tar -czvf lavagna.tar.gz *

docker-compose build lavagna

aws ecr get-login-password --region eu-west-3 | docker login --username AWS --password-stdin 644435390668.dkr.ecr.eu-west-3.amazonaws.com

docker push 644435390668.dkr.ecr.eu-west-3.amazonaws.com/nathan-lavagna:latest

ssh -t $1 "rm -rf /home/ec2-user/lavagna && mkdir /home/ec2-user/lavagna"

scp -i "/home/nathan/Desktop/rsa-key.pem/lavagna-aws.pem -r /home/nathan/Desktop/rsa-key.pem/lavagna/project/lavagna.tar.gz $1:./lavagna"

ssh -t $1 "cd /home/ec2-user/lavagna && tar -xvzf /home/ec2-user/lavagna/lavagna.tar.gz"

ssh -t $1 "aws ecr get-login-password --region eu-west-3 | docker login --username AWS --password-stdin 644435390668.dkr.ecr.eu-west-3.amazonaws.com"

ssh -t $1 "docker-compose -f /home/ec2-user/lavagna/docker-compose.yml up"