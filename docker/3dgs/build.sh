#!/bin/bash

# Fail on first error
set -e

# Define image name and tag
REPO="docker.io/patrickwang97"
IMAGE_NAME="3dgs"
TAG="latest"

# Get the directory where the script is located
REPO_ROOT=$(git rev-parse --show-toplevel)
WORKSPACE_DIR=$REPO_ROOT/docker/3dgs
cd $REPO_ROOT

# Copy gaussian_splatting into the build context
rm -rf "$WORKSPACE_DIR/gaussian_splatting"
cp -r "$REPO_ROOT/gaussian_splatting" "$WORKSPACE_DIR/gaussian_splatting"
# cp -r $REPO_ROOT/diffusion/models--runwayml--stable-diffusion-v1-5 $WORKSPACE_DIR/models--runwayml--stable-diffusion-v1-5
echo "Copied gaussian_splatting into $WORKSPACE_DIR"

# Build the Docker image
echo "🔧 Building Docker image: $IMAGE_NAME:$TAG"
docker build \
    -f "$WORKSPACE_DIR/Dockerfile" \
    -t "$REPO/$IMAGE_NAME:$TAG" "$WORKSPACE_DIR"

echo "✅ Built docker image $IMAGE_NAME:$TAG successfully"

docker push "$REPO/$IMAGE_NAME:$TAG"
echo "✅ Pushed docker image $IMAGE_NAME:$TAG successfully"

# Remove the copied gaussian_splatting to clean up
rm -rf "$WORKSPACE_DIR/gaussian_splatting"
# rm -rf $WORKSPACE_DIR/models--runwayml--stable-diffusion-v1-5
echo "Finish cleaning up $WORKSPACE_DIR"