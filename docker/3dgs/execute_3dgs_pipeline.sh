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
  --model_path $gaussian_splatting_output_dir \
  --eval \
  --use_difix --distillation_iteration 50

# Render
python3 gaussian-splatting/render.py -m $gaussian_splatting_output_dir

# Generate novel-view videos
novel_view_video_dir="$gaussian_splatting_output_dir/videos"
novel_rendering_dir="$gaussian_splatting_output_dir/novel_view/ours_30000"
mkdir -p $novel_view_video_dir


# iterate over each camera and generate video
camera_list=("CAM_FRONT" "CAM_FRONT_LEFT" "CAM_FRONT_RIGHT" "CAM_BACK" "CAM_BACK_LEFT" "CAM_BACK_RIGHT")
for cam in "${camera_list[@]}"; do
  echo "Rendering novel view for $cam..."
  python3 gaussian-splatting/novel_view_render.py -m $gaussian_splatting_output_dir --camera_name "$cam"
  echo "Encoding video for $cam..."
  ffmpeg -y -framerate 60 \
    -i "$novel_rendering_dir/$cam/%05d.png" \
    -c:v libx264 \
    -pix_fmt yuv420p \
    -vf "pad=ceil(iw/2)*2:ceil(ih/2)*2" \
    "$novel_view_video_dir/${cam}.mp4"
done

# Metrics
python3 python3 gaussian-splatting/metrics.py -m $gaussian_splatting_output_dir

echo "3DGS pipeline completed"