#!/bin/bash
set -e

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <input_dir> <workspace_dir>"
  exit 1
fi

# folder that stores all the images
input_dir="$1"
workspace_dir="$2"

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
  patrickwang97/di3dgs:latest