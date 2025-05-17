# Chnage those parameters based on your architecture/setup
ARG UBUNTU_VERSION=22.04
ARG NVIDIA_CUDA_VERSION=11.8.0
ARG TORCH_CUDA_ARCH=8.6

FROM nvidia/cuda:${NVIDIA_CUDA_VERSION}-devel-ubuntu${UBUNTU_VERSION}

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
      python3.10 python3.10-distutils python3-pip python3.10-dev \
      git wget build-essential ninja-build \
      libgl1-mesa-glx libglib2.0-0 \
      libglew-dev libfreeimage-dev \
      imagemagick \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip to the exact version you want  
RUN python3.10 -m pip install --upgrade pip==23.1.2

# Python deps (PyTorch wheels with CUDA support)
RUN pip install --no-cache-dir \
      "numpy<2.0" \
      plyfile \
      tqdm \
      opencv-python \
      joblib

RUN pip install --no-cache-dir \
      torch torchvision \
      torchaudio \
      --index-url https://download.pytorch.org/whl/cu118

# Workspace & your code
WORKDIR /workspace
RUN mkdir -p /workspace/input
RUN mkdir -p /workspace/output
COPY gaussian_splatting /workspace/gaussian-splatting

# Force Torch extension build to target the correct compute capability
ENV CUDA_HOME="/usr/local/cuda"
ENV TORCH_CUDA_ARCH_LIST="${TORCH_CUDA_ARCH}"

# Install your local submodules
RUN pip install \
      /workspace/gaussian-splatting/submodules/diff-gaussian-rasterization \
      /workspace/gaussian-splatting/submodules/simple-knn \
      /workspace/gaussian-splatting/submodules/fused-ssim

CMD ["bash"]