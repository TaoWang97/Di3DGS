#!/bin/bash

# Fail on first error
set -e

# Define image name and tag
REPO="docker.io/patrickwang97"
IMAGE_NAME="colmap"
TAG="latest"

# Get the directory where the script is located
REPO_ROOT=$(git rev-parse --show-toplevel)
DOCKERFILE_PATH=$REPO_ROOT/docker/colmap/Dockerfile
cd $REPO_ROOT

# Build the Docker image
echo "🔧 Building Docker image: $IMAGE_NAME:$TAG"
docker build \
    -f "$DOCKERFILE_PATH" \
    -t "$REPO/$IMAGE_NAME:$TAG" "$REPO_ROOT"

echo "✅ Docker image $IMAGE_NAME:$TAG built successfully"

docker push "$REPO/$IMAGE_NAME:$TAG"
echo "✅ Pushed docker image $IMAGE_NAME:$TAG successfully"