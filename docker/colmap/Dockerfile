# Chnage those parameters based on your architecture/setup
ARG UBUNTU_VERSION=22.04
ARG NVIDIA_CUDA_VERSION=11.8.0
ARG CUDA_ARCHITECTURES=86


FROM nvidia/cuda:${NVIDIA_CUDA_VERSION}-devel-ubuntu${UBUNTU_VERSION}


ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    git cmake ninja-build build-essential \
    libboost-program-options-dev libboost-graph-dev \
    libboost-system-dev libeigen3-dev libflann-dev \
    libfreeimage-dev libmetis-dev libgoogle-glog-dev \
    libgtest-dev libgmock-dev libsqlite3-dev libglew-dev \
    qtbase5-dev libqt5opengl5-dev libcgal-dev libceres-dev \
    libmetis-dev gcc-10 g++-10 \
    libx11-xcb1 libxcb1 libxcb-glx0 libxcb-keysyms1 libxcb-image0 \
    libxcb-shm0 libxcb-icccm4 libxcb-sync1 libxcb-xfixes0 \
    libxcb-shape0 libxcb-randr0 libxcb-render-util0 libxcb-xinerama0 \
    libxkbcommon-x11-0 libxcb-util1 \
    mesa-utils libgl1-mesa-glx \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /opt
RUN git clone --recursive https://github.com/colmap/colmap.git

WORKDIR /opt/colmap/build
ENV CC=/usr/bin/gcc-10
ENV CXX=/usr/bin/g++-10
ENV CUDAHOSTCXX=/usr/bin/g++-10

RUN cmake .. -GNinja \
      -DCUDA_ENABLED=ON \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_CUDA_ARCHITECTURES=${CUDA_ARCHITECTURES} \
    && ninja \
    && ninja install

WORKDIR /workspace
RUN mkdir -p /workspace/input
RUN mkdir -p /workspace/output

ENTRYPOINT ["colmap", "automatic_reconstructor", "--image_path", "/workspace/input", "--workspace_path", "/workspace/output"]
