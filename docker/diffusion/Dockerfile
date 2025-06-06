# CUDA 12.1 + PyTorch 2.1
FROM pytorch/pytorch:2.1.0-cuda12.1-cudnn8-runtime

# System deps
RUN apt-get update && apt-get install -y git curl && rm -rf /var/lib/apt/lists/*

# Python deps
RUN pip install --no-cache-dir \
    "git+https://github.com/huggingface/diffusers.git" \
    transformers==4.39.3 \
    accelerate>=0.26 \
    scipy \
    ftfy python-multipart \
    fastapi uvicorn[standard] pillow

COPY models--runwayml--stable-diffusion-v1-5 /opt/hf_cache/models--runwayml--stable-diffusion-v1-5

# (Optional) pre-download weights so cold-starts are fast
ENV HF_HOME=/opt/hf_cache
RUN python - <<'PY'
import torch
from diffusers import StableDiffusionImg2ImgPipeline
StableDiffusionImg2ImgPipeline.from_pretrained(
    "/opt/hf_cache/models--runwayml--stable-diffusion-v1-5/snapshots/451f4fe16113bff5a5d2269ed5ad43b0592e9a14",
    torch_dtype=torch.float16,
    local_files_only=True)
PY

# Runtime
COPY app.py app.py
EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=3s --start-period=10s \
  CMD curl -f http://localhost:8080/healthz || exit 1
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8080"]