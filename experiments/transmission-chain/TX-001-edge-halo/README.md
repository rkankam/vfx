# TX-001 — Edge Halo / Degraded Electronic Video

Status: **PROVEN**  
Date: 2026-09-06  
Preset: `tx_analog_edge_halo_v0.1`  
Next unknown: [TX-002](https://github.com/rkankam/vfx/issues/1)

## Question

Can the characteristic halo / overdefined-edge appearance of the target reference be reproduced as a **consequence of a transmission chain** rather than as a decorative `VHS halo` effect added at the end?

## Result

**Yes, for the target perceptual family.**

A two-generation FFmpeg chain produced a result judged probative in the live experiment. The useful behavior came from sequencing several operations:

```text
strong luma edge enhancement
→ real low-resolution working stage
→ mild luma blur
→ much stronger chroma blur
→ chroma misregistration
→ modest noise
→ MPEG-2 generation loss
→ decode
→ upscale
→ weak secondary digital sharpening
→ H.264 delivery
```

The successful output was not interesting because it looked maximally damaged. It was interesting because it created the contradiction:

> **soft surfaces + hard/artificial surviving edges + chroma spread**

That contradiction is the fingerprint to preserve.

## What the experiment established

### 1. Sharpen before degrading

The first sharpening stage is intentionally strong and luma-only. It creates edge overshoot while the image still contains enough structure for the filter to detect high-contrast boundaries.

The later low-resolution and bandwidth-loss stages remove internal detail more aggressively than the artificial contour. The contour therefore survives as an exaggerated halo while faces, fabric and other surfaces become soft.

This is materially different from blurring an image and applying one sharpening pass at the end.

### 2. Luma and chroma should not be degraded equally

The proof keeps luminance relatively legible while making chroma much softer and slightly misregistered.

This produces a video-like relationship in which:

- structure remains more precise than color;
- color spreads outside the structural edge;
- bright/cyan borders can emerge around high-contrast subjects;
- the image reads as a damaged signal rather than uniformly blurred photography.

### 3. Work at genuinely low resolution

The first generation is processed at `288x512`, not at delivery resolution.

Pixel-scale defects such as blur radius and chroma shift therefore become large enough to matter after reconstruction. Applying the same nominal shifts directly to a high-resolution master would produce a much weaker perceptual effect.

### 4. Generation loss is part of the material

The first pass is encoded to MPEG-2 and then decoded for the second pass.

This is deliberate. The first generation's filtering and codec errors become the signal consumed by the reconstruction stage. The second stage does not know which edges are original and which are artefacts.

The pipeline therefore models:

```text
error at generation N
→ accepted as signal by generation N+1
```

rather than merely adding a final compression overlay.

### 5. Two sharpening stages represent different causes

The strong first sharpening models camera/electronic detail enhancement.

The weak final sharpening models a later capture, resize, remaster, platform, or consumer-side enhancement stage.

The same mathematical operation can therefore have different semantic roles depending on where it appears in the chain.

## Exact proof pipeline

The exact command used for the accepted proof is preserved in [`pipeline.sh`](./pipeline.sh).

### Generation 1

Working transform:

```text
input 512x910 H.264
→ yuv444p
→ luma unsharp: 11x11, amount 2.25
→ scale to 288x512 bicubic
→ luma gaussian blur sigma 0.50
→ chroma gaussian blur sigma 2.15
→ Cb shift +3 px, Cr shift +1 px, smear edge handling
→ temporal noise Y=6 / Cb=3 / Cr=3
→ yuv420p
→ MPEG-2 q=8 @ 30 fps
```

### Generation 2 / delivery

```text
MPEG-2 generation
→ decode
→ scale to 512x910 bicubic
→ luma unsharp 5x5, amount 0.45
→ yuv420p
→ H.264 CRF 24
→ original audio re-encoded AAC 160k
```

## Evidence

The current repository intentionally does not republish the conversation-provided reference or test video because this repository is public and the media provenance/redistribution rights were not established during the experiment.

Instead, [`evidence-manifest.yaml`](./evidence-manifest.yaml) preserves:

- exact local filenames;
- SHA-256 digests;
- dimensions/duration/codecs;
- output proof digest;
- comparison-image digest;
- validation state.

This is sufficient to identify the exact assets if they are later moved into an authorized media store.

## What is **not** proven

TX-001 does **not** establish:

- the exact historical acquisition chain of the reference;
- that the reference necessarily passed through VHS;
- that the reference necessarily passed through composite NTSC or PAL;
- that MPEG-2 existed in the original reference chain;
- that the halo has one unique physical cause;
- that these parameter values generalize to every source resolution or framing;
- that this is a historically faithful emulator of one named camera, tape format, broadcaster, or capture card.

The proof establishes a **reusable perceptual mechanism**, not a forensic attribution.

## Why this matters

A naive request such as:

```text
make it vintage / VHS / blurry / low quality
```

collapses several historically distinct transformations into one style label.

TX-001 supports a better working question:

> What sequence of acquisition, correction, bandwidth, storage, copying, decoding and delivery transformations could generate the visible fingerprint?

The resulting pipeline can be reasoned about, mutated, falsified and reused.

## Closure

TX-001 is closed.

Do not continue tuning the accepted proof merely because more knobs exist. Any new exploration should begin from a new question with a separate identifier.

The next bounded question is TX-002: whether a true composite-signal simulation stage adds perceptual value that survives delivery.
