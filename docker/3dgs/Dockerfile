# Chnage those parameters based on your architecture/setup
ARG UBUNTU_VERSION=22.04
ARG NVIDIA_CUDA_VERSION=11.8.0

FROM nvidia/cuda:${NVIDIA_CUDA_VERSION}-devel-ubuntu${UBUNTU_VERSION}

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
      python3.10 python3.10-distutils python3-pip python3.10-dev \
      git wget build-essential ninja-build \
      libgl1-mesa-glx libglib2.0-0 \
      libglew-dev libfreeimage-dev \
      imagemagick libassimp-dev \
      libboost-all-dev libgtk-3-dev \
      libopencv-dev libglfw3-dev \
      libavdevice-dev libavcodec-dev \
      libeigen3-dev libxxf86vm-dev \
      libembree-dev cmake ffmpeg\
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

RUN pip install --no-cache-dir \
      transformers \
      scipy \
      ftfy \
      accelerate \
      "ipywidgets>=7,<8" \
      "git+https://github.com/huggingface/diffusers.git"

# Workspace & your code
WORKDIR /workspace
RUN mkdir -p /workspace/input
RUN mkdir -p /workspace/output
COPY gaussian_splatting /workspace/gaussian-splatting
# COPY models--runwayml--stable-diffusion-v1-5 /workspace/models--runwayml--stable-diffusion-v1-5

RUN cd /workspace/gaussian-splatting/SIBR_viewers && \
    cmake -B build . -DCMAKE_BUILD_TYPE=Release -G Ninja && \
    cmake --build build -j24 --target install

# Force Torch extension build to target the correct compute capability
ENV CUDA_HOME="/usr/local/cuda"
ENV TORCH_CUDA_ARCH_LIST=8.6

# Install your local submodules
RUN pip install \
      /workspace/gaussian-splatting/submodules/diff-gaussian-rasterization \
      /workspace/gaussian-splatting/submodules/simple-knn \
      /workspace/gaussian-splatting/submodules/fused-ssim


COPY execute_3dgs_pipeline.sh /workspace/execute_3dgs_pipeline.sh
RUN chmod +x /workspace/execute_3dgs_pipeline.sh
      
ENTRYPOINT ["/workspace/execute_3dgs_pipeline.sh"]