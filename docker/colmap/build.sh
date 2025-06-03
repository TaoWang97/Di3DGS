#!/bin/bash

# Fail on first error
set -e

# Define image name and tag
REPO="docker.io/patrickwang97"
IMAGE_NAME="colmap"
TAG="latest"

# Get the directory where the script is located
REPO_ROOT=$(git rev-parse --show-toplevel)
WORKSPACE_DIR=$REPO_ROOT/docker/colmap
cd $REPO_ROOT

# Build the Docker image
echo "🔧 Building Docker image: $IMAGE_NAME:$TAG"
docker build \
    -f "$WORKSPACE_DIR/Dockerfile" \
    -t "$REPO/$IMAGE_NAME:$TAG" "$WORKSPACE_DIR"

echo "✅ Docker image $IMAGE_NAME:$TAG built successfully"

# docker push "$REPO/$IMAGE_NAME:$TAG"
echo "✅ Pushed docker image $IMAGE_NAME:$TAG successfully"