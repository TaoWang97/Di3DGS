# app.py
import io
from fastapi import FastAPI, UploadFile
from fastapi.responses import StreamingResponse
from PIL import Image
import torch, torchvision.transforms as T
from diffusers import StableDiffusionImg2ImgPipeline

DEVICE = "cuda" if torch.cuda.is_available() else "cpu"

pipe = StableDiffusionImg2ImgPipeline.from_pretrained(
        "/opt/hf_cache/models--runwayml--stable-diffusion-v1-5/snapshots/451f4fe16113bff5a5d2269ed5ad43b0592e9a14",
        torch_dtype=torch.float16 if DEVICE == "cuda" else torch.float32,
        local_files_only=True
).to(DEVICE)
pipe.set_progress_bar_config(disable=True)
pipe.safety_checker = None   # optional

app = FastAPI()
to_pil = T.ToPILImage()
to_tensor = T.ToTensor()

PROMPT_DEFAULT   = "A sharp, high-resolution photo of a road scene, no blur, no motion artifacts"
NEG_DEFAULT      = "blurry, warped, noisy, distorted, painterly"

@app.post("/clean")
async def clean(image: UploadFile,
                prompt: str = PROMPT_DEFAULT,
                negative_prompt: str = NEG_DEFAULT,
                strength: float = 0.30,
                guidance_scale: float = 7.5,
                steps: int = 60):
    pil_in = Image.open(io.BytesIO(await image.read())).convert("RGB")
    result = pipe(prompt=prompt,
                  negative_prompt=negative_prompt,
                  image=pil_in,
                  strength=strength,
                  guidance_scale=guidance_scale,
                  num_inference_steps=steps).images[0]
    buf = io.BytesIO()
    result.save(buf, format="PNG")
    buf.seek(0)
    return StreamingResponse(buf, media_type="image/png")

@app.get("/healthz")
def ping():
    return {"ok": True}