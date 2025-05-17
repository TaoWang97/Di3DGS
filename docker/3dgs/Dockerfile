FROM nvidia/cuda:11.8.0-devel-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
      python3.10 python3.10-distutils python3-pip \
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
      joblib \
      torch==2.6.0 \
      torchvision==0.21.0 \
      torchaudio==2.6.0 \
      -f https://download.pytorch.org/whl/cu118/torch_stable.html

# Workspace & your code
WORKDIR /workspace
RUN mkdir -p /workspace/input
RUN mkdir -p /workspace/output
COPY gaussian_splatting /workspace/gaussian-splatting

# Install your local submodules
RUN pip install --no-cache-dir \
      /workspace/gaussian-splatting/submodules/diff-gaussian-rasterization \
      /workspace/gaussian-splatting/submodules/simple-knn \
      /workspace/gaussian-splatting/submodules/fused-ssim

CMD ["bash"]