#!/bin/bash
set -e

# Input directory of images
input_dir="/home/patrick-wang/Documents/personal/Di3DGS/test/input"
workspace_dir="/home/patrick-wang/Documents/personal/Di3DGS/test/workspace"

echo -e "\e[1;34m========================================\e[0m"
echo -e "\e[1;32m    🚀 Running the COLMAP Pipeline 🚀    \e[0m"
echo -e "\e[1;34m========================================\e[0m"
# Run the colmap pipeline
docker run --rm --gpus all \
  -v $input_dir:/workspace/input \
  -v $workspace_dir:/workspace/output \
  patrickwang97/colmap:latest

# Run the 3DGS pipeline
echo -e "\e[1;34m========================================\e[0m"
echo -e "\e[1;33m    🌟 Running the 3DGS Pipeline 🌟      \e[0m"
echo -e "\e[1;34m========================================\e[0m"
docker run --rm --gpus all \
  -v $workspace_dir:/workspace/input \
  -v $workspace_dir:/workspace/output \
  patrickwang97/3dgs:latest