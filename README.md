# Di3DGS

Command to run colmap:

docker run --rm -it \
  --gpus all \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /abs_path/to/image_folder:/workspace/input \
  -v /abs_path/to/output:/workspace/output \
  colmap:latest