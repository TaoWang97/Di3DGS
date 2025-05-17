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
The default CUDA version is 11.8
However, you can build your docker images simply by replacing parameters in the Dockerfile based on your hardware.
```bash
ARG NVIDIA_CUDA_VERSION=11.8.0
ARG TORCH_CUDA_ARCH=8.6
ARG CUDA_ARCHITECTURES=86
```


## COLMAP
Pull the repo from a docker registry:
```bash
docker pull docker.io/patrickwang97/colmap
```

Command to run colmap:
```bash
docker run --rm -it \
  --gpus all \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /abs_path/to/image_folder:/workspace/input \
  -v /abs_path/to/output:/workspace/output \
  colmap:latest
```

## 3DGS
Pull the repo from a docker registry:
```bash
docker pull docker.io/patrickwang97/3dgs
```
Command to run colmap:
```bash
docker run --rm -it \
  --gpus all \
  -v /abs_path/to/image_folder:/workspace/input \
  -v /abs_path/to/output:/workspace/output \
  3dgs:latest
```
