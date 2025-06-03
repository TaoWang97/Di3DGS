#!/bin/bash 

# Fail on first error
set -e

# Input directory of images
input_dir="/workspace/input"
workspace_dir="/workspace/output"

# Colmap directory
colmap_output_dir="$workspace_dir/colmap"
undistorted_colmap_output_dir="$workspace_dir/undistorted_colmap"
mkdir -p $colmap_output_dir
mkdir -p $undistorted_colmap_output_dir

colmap automatic_reconstructor \
  --workspace_path $colmap_output_dir \
  --image_path $input_dir \
  --data_type individual \
  --quality high \
  --extraction 1 \
  --matching 1 \
  --sparse 1 \
  --dense 0 \
  --use_gpu 1

colmap image_undistorter \
  --image_path $input_dir \
  --input_path $colmap_output_dir/sparse/0 \
  --output_path $undistorted_colmap_output_dir \
  --output_type COLMAP \
  --max_image_size 2000

mkdir -p $undistorted_colmap_output_dir/sparse/0
mv $undistorted_colmap_output_dir/sparse/*.bin $undistorted_colmap_output_dir/sparse/0
echo "Colmap pipeline completed"