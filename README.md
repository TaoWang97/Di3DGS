# Di3DGS
Clone the repo:
```bash
git clone --recursive git@github.com:TaoWang97/Di3DGS.git
```

If you haven't used --recursive, then run:
```bash
git submodule update --init --recursive
```
## Hardware Requirement
The default CUDA version is 11.8, GPU memory is 24 GB. \
However, you can build your docker images simply by replacing parameters in the Dockerfile based on your hardware.
```bash
ARG NVIDIA_CUDA_VERSION=11.8.0
ARG TORCH_CUDA_ARCH=8.6
ARG CUDA_ARCHITECTURES=86
```

## Run The Entire Pipeline
./scripts/run_pipeline.sh <ABS_IMAGE_FOLDER_NAME> <ABS_WORKSPACE_DIR>

## COLMAP
Pull the repo from a docker registry:
```bash
docker pull docker.io/patrickwang97/colmap
```

Command to run colmap:
```bash
docker run --rm --gpus all \
  -v /abs_path/to/image_folder:/workspace/input \
  -v /abs_path/to/workspace_folder:/workspace/output \
  patrickwang97/colmap:latest
```

## Di3DGS
Pull the repo from a docker registry:
```bash
docker pull docker.io/patrickwang97/di3dgs
```
Command to run colmap:
```bash
docker run --rm -it \
  --gpus all \
  -v /abs_path/to/workspace_folder:/workspace/input \
  -v /abs_path/to/workspace_folder:/workspace/output \
  di3dgs:latest
```


<video controls width="640" src="https://github.com/TaoWang97/Di3DGS/blob/master/videos/front.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>