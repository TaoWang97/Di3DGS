# Di3DGS

Diffusion-Guided Gaussian Splatting (Di3DGS) is a hybrid 3D reconstruction model that combines Gaussian splatting with a diffusion-based clean-up step. It generates visually consistent 3D scenes from sparse camera inputs, supporting downstream tasks like object tracking, planning, and occlusion reasoning in autonomous driving scenarios.

![Di3DGS Demo](assets/demo.gif)

## Video Comparison
Our dataset consists of 39 frames captured at 1 fps. We interpolate between each pair of original poses to upsample the sequence to 30 poses per second. For the video comparison, we train on all available views—none are held out—and simply treat those interpolated poses as our “hold-out” cameras. Using higher‐frame‐rate input data will lead to improved results.

## Quantitative Results

| Model                    | PSNR      | SSIM      | LPIPS      |
|--------------------------|-----------|-----------|------------|
| 3D Gaussian Splatting    | 21.9095363| 0.79961448| 0.3499600  |
| Our Model (Di3DGS)       | 25.6269416| 0.84147250| 0.286909192|

**Analysis**

Across all three metrics, our Di3DGS model shows clear improvements over vanilla 3D Gaussian Splatting:

- **PSNR** (higher is better):  A boost of nearly 4 dB halves the pixel-level reconstruction error, making Di3DGS visibly sharper.

- **SSIM** (higher is better, 0–1 range):  With ∼5.2% relative increase, indicates stronger preservation of edges, textures, and overall scene structure.

- **LPIPS** (lower is better, 0–1 range): A significant drop, ∼18% relative, in perceptual distance means reconstructions align more closely with human judgments.

**Practical impact**  
- **Sharper details:** The PSNR/SSIM gains translate into crisper edges and finer texture recovery.  
- **Fewer artifacts:** The LPIPS reduction corroborates the visual artifact removal—less ghosting and blotchiness.  
- **More stable renderings:** Higher structural fidelity per SSIM means less frame-to-frame jitter in videos.

These results confirm that Di3DGS delivers both stronger quantitative scores and noticeably better visual fidelity.  


### Front Camera
https://github.com/user-attachments/assets/211c9576-0655-48ec-bcd8-9db28349a620
### Front-Left Camera
https://github.com/user-attachments/assets/43f7c1b6-4ece-4924-b5b9-f2e176ed9aa1
### Front-Right Camera
https://github.com/user-attachments/assets/3c1f8bed-0b96-4183-86cf-1121d2109ae5
### Back Camera
https://github.com/user-attachments/assets/7094dc46-5087-489a-b27e-b6a597877f6d
### Back-Left Camera
https://github.com/user-attachments/assets/e3850a9c-2d82-4cdc-97a0-69d9ef93a695
### Back-Right Camera
https://github.com/user-attachments/assets/36ffb211-6af2-4384-bfcf-c374ed26fd8a

## Setup

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

## End-to-End Pipeline Execution
This script will run both the COLMAP SfM steps and our Di3DGS reconstruction in one go, producing everything from sparse point clouds to fly‐through videos.
```bash
./scripts/run_pipeline.sh <ABS_IMAGE_FOLDER_NAME> <ABS_WORKSPACE_DIR>
```
- **`<ABS_IMAGE_DIR>`**: Absolute path to the directory containing your input images (e.g., extracted video frames).
- **`<ABS_WORKSPACE_DIR>`**: Absolute path to the workspace folder where all intermediate and final outputs will be written. This includes:
  - COLMAP databases and sparse/dense reconstructions  
  - 3DGS and Di3DGS model checkpoints and rendered frames  
  - Final fly-through videos for each camera

### Dataset Example
- **Scene 1 (Big)**  
  Download from: [Scene 1 (Big) dataset on GitHub](https://github.com/TaoWang97/Di3DGS/tree/master/data_set/scene1/big)

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








