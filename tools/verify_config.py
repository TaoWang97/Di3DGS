import torch
import subprocess

print("PyTorch version:", torch.__version__)
print("Built with CUDA version (torch.version.cuda):", torch.version.cuda)

# Your system CUDA toolkit version
nvcc = subprocess.check_output(["nvcc", "--version"]).decode().strip()
print("nvcc output:\n", nvcc)

# NVIDIA driver/runtime info
nvidia_smi = subprocess.check_output(["nvidia-smi"]).decode().strip()
print("nvidia-smi output:\n", nvidia_smi)