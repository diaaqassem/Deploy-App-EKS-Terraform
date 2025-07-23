#!/bin/bash
REPO_URL="717279709688.dkr.ecr.us-east-1.amazonaws.com/eyego-repo"
IMAGE_NAME="eyego-app"

echo "logging in to ECR"
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $REPO_URL

echo "building docker image"
docker build -t $REPO_URL:latest .

echo "push image to ECR"
docker push $REPO_URL:latest
