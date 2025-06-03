#!/bin/bash

# Fail on first error
set -e

# Input directory of images
input_dir="/workspace/input"
workspace_dir="/workspace/output"

# Undistorted colmap output directory
undistorted_colmap_output_dir="$input_dir/undistorted_colmap"

# Gaussian splatting output directory
gaussian_splatting_output_dir="$workspace_dir/gaussian_splatting"
mkdir -p $gaussian_splatting_output_dir

# Run the 3DGS pipeline
python3 gaussian-splatting/train.py \
  -s $undistorted_colmap_output_dir \
  --model_path $gaussian_splatting_output_dir

echo "3DGS pipeline completed"
