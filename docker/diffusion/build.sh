#!/bin/bash

# Fail on first error
set -e

# Define image name and tag
REPO="docker.io/patrickwang97"
IMAGE_NAME="diffusion"
TAG="latest"

# Get the directory where the script is located
REPO_ROOT=$(git rev-parse --show-toplevel)
WORKSPACE_DIR=$REPO_ROOT/docker/diffusion
cd $REPO_ROOT

cp $REPO_ROOT/diffusion/app.py $WORKSPACE_DIR/app.py
cp -r $REPO_ROOT/diffusion/models--runwayml--stable-diffusion-v1-5 $WORKSPACE_DIR

# Build the Docker image
echo "🔧 Building Docker image: $IMAGE_NAME:$TAG"
docker build \
    -f "$WORKSPACE_DIR/Dockerfile" \
    -t "$REPO/$IMAGE_NAME:$TAG" "$WORKSPACE_DIR"

echo "✅ Docker image $IMAGE_NAME:$TAG built successfully"

docker push "$REPO/$IMAGE_NAME:$TAG"
echo "✅ Pushed docker image $IMAGE_NAME:$TAG successfully"

rm -rf $WORKSPACE_DIR/app.py
rm -rf $WORKSPACE_DIR/models--runwayml--stable-diffusion-v1-5