# Transmission Chain as an Aesthetic System

Status: active principle  
Origin experiment: TX-001  
Date: 2026-09-06

## Thesis

A historical or degraded-media aesthetic should not be modeled only as a collection of visible defects.

A more useful model is the **sequence of transformations that carried the signal from source to viewer**:

```text
SOURCE
→ ACQUISITION
→ CAMERA / DEVICE PROCESSING
→ CORRECTION
→ TRANSMISSION
→ STORAGE
→ COPYING
→ DECODING
→ DIGITAL CAPTURE
→ RESAMPLING
→ DELIVERY CODEC
→ DISPLAY
```

Each stage consumes the output of the previous stage. Therefore a defect created early can be blurred, sharpened, compressed, shifted, aliased, or partially erased later.

The final aesthetic is often an interaction between stages rather than one isolated defect.

## Why this matters

A label such as:

```text
VHS
CRT
MiniDV
old TV
90s OVA
2004 webcam
bad MPEG
JPEG forum image
```

compresses an entire technical history into one noun.

That noun can be useful for reference discovery, but it is weak as a production specification.

A production specification asks instead:

```text
What was captured?
What did the device do to improve it?
What bandwidth was available?
How was color represented relative to luminance?
How was the signal stored?
Was it copied?
How was it decoded?
Was it resized or sharpened later?
What codec or display transformed it again?
```

This changes post-production from **style imitation** into **causal reconstruction**.

## TX-001 discovery

The first qualified case was an archival/electronic-video reference with conspicuous light/cyan contours around people and objects.

The important observation was that the image was not simply soft.

It simultaneously contained:

- weak internal texture;
- conspicuous high-contrast boundaries;
- color that was less spatially precise than structure;
- visible edge overshoot / halo behavior;
- evidence compatible with more than one generation of processing.

The useful hypothesis was therefore not:

```text
old image → blur it
```

but:

```text
edge enhancement
→ bandwidth loss
→ stronger chroma loss
→ chroma misregistration
→ generation loss
→ reconstruction / later sharpening
```

A FFmpeg proof validated that this sequence can reproduce the target perceptual family.

## Core invariant: corrections can become defects

One of the most important lessons from TX-001 is that a visually "bad" historical image can contain artefacts produced by systems that were trying to make the image look **better**.

Electronic detail enhancement is a good example.

When native resolution or bandwidth is limited, a device can increase perceived sharpness by exaggerating transitions. The process does not restore missing information. It produces stronger boundaries.

If that enhanced image is then degraded, the internal texture can disappear while the artificial contour survives.

This yields:

```text
correction
→ later degradation
→ signature defect
```

Therefore:

> **The interesting defect may be the residue of a correction that was subsequently damaged.**

This is more general than edge sharpening. Similar reasoning should be tested whenever historical systems included denoising, AGC, color correction, deinterlacing, overscan, resampling, error concealment, or other compensatory stages.

## Core invariant: errors become signal

A later stage has no privileged knowledge of what was "original".

Once a halo, ringing pattern, codec block, chroma offset, or line error exists in generation N, it is simply part of the input to generation N+1.

Therefore:

```text
error_N
→ encode/copy/resize
→ transformed_error_N+1
```

This explains why a copied or web-encoded archival image often cannot be reproduced convincingly by adding all visible defects independently at the end.

The defects have already interacted.

## Core invariant: structure and color have different histories

Many video systems preserve luminance and chrominance with different bandwidth, sampling, modulation, delay, and compression constraints.

A useful production rule is therefore:

> Do not assume that Y, Cb and Cr should lose detail at the same rate.

A simple FFmpeg approximation already demonstrates the value of:

```text
luma: relatively legible
chroma: much softer + slightly shifted
```

The result can retain recognizable structural edges while allowing color to bleed outside them.

This is materially different from a global RGB blur.

## Core invariant: resolution is part of the effect

Many defect parameters are expressed in pixels.

A two-pixel chroma shift at 4K is tiny. The same two-pixel shift at a 288-pixel-wide working stage can become a major visible defect after upscale.

Therefore:

> **Apply pixel-scale signal defects at the resolution where the historical or simulated process would plausibly operate.**

Do not merely shrink the final output after building all effects at the master resolution.

## Distinguish semantic stages even when they use the same filter

Two `unsharp` operations can represent different phenomena:

```text
pre-degradation unsharp
= camera / electronic detail correction

post-degradation unsharp
= later capture / resize / platform enhancement
```

The mathematical operator is not the aesthetic meaning.

The meaning comes from:

- stage position;
- input it receives;
- defects already present;
- transformations that follow it.

This is a useful rule for any config-driven VFX system: store both **operator parameters** and **semantic role**.

## "Bad signal" is not the same as "maximal VHS damage"

A frequent failure mode in synthetic vintage work is to over-index on obvious damage:

- tracking bars;
- snow;
- scanlines;
- horizontal tearing;
- giant color offsets;
- timestamp overlays;
- random glitch.

These can be valid for specific chains, but they are not required for an image to feel technically old or degraded.

TX-001 worked with relatively modest noise because the important failure was in the **signal representation and its generations**, not spectacle.

A useful distinction is:

```text
damaged tape aesthetic
vs
poor/processed electronic signal aesthetic
```

The second can be much quieter and still more convincing.

## Production method

For a target reference, use this investigation order.

### 1. Observe the fingerprint

Describe contradictions, not only defects.

Examples:

- soft surfaces but sharp contours;
- stable luma but unstable color;
- strong horizontal softness but legible vertical transitions;
- clean geometry but blocky motion;
- stable frame with unstable line timing;
- bright-edge glow without optical bloom.

### 2. Assign candidate causes

Classify each observation by possible stage:

```text
optics
sensor / tube
camera processing
color encoding
composite/component transmission
recording medium
copy generation
playback / timebase
capture card
resampling
codec
platform
screen
```

Do not assume one cause per defect.

### 3. Build the smallest causal chain

Start with the minimum sequence that could produce the contradictions.

Avoid adding every famous artefact associated with the era.

### 4. Reproduce and validate

Run the chain on a real test source and compare at delivery resolution.

A reference analysis that has not survived an applied proof remains a hypothesis.

### 5. Freeze the successful chain

Preserve exact commands, input/output identity, parameter values, and non-claims.

### 6. Extract the invariant

The reusable knowledge should be more abstract than one command but more precise than a style word.

For TX-001:

```text
sharpen before degrade
chroma loss > luma loss
low-resolution defect stage
real generation loss
weak later reconstruction sharpening
```

### 7. Park the next unknown

Do not automatically extend a successful experiment into a larger research program.

Create a bounded next question and stop.

## Candidate transmission-chain families

The following are useful future families, not presets yet:

### Broadcast / electronic archive

```text
camera processing
→ analog/component/composite transmission
→ broadcast chain
→ capture
→ web encode
```

### VHS generation

```text
camera processing
→ composite/component source
→ VHS record/playback
→ composite output
→ digital capture
→ delivery
```

### Nth-generation archive

```text
camera
→ tape master
→ copy
→ broadcast
→ domestic recording
→ copy
→ digital capture
→ MPEG/web transcode
```

### Early digital consumer video

```text
sensor
→ in-camera sharpening / NR
→ chroma subsampling
→ DV/MPEG compression
→ NLE resize
→ web codec
```

Each family should be qualified through references rather than treated as a ready-made style preset.

## Anti-patterns

Avoid treating these as sufficient specifications:

```text
vintage=true
VHS overlay
add grain
add blur
add chromatic aberration
add scanlines
lower resolution
```

They can be implementation details, but without a chain they do not explain why they are present or in what order they should occur.

Also avoid historical overclaiming. A visually plausible reconstruction does not prove the source's actual technical provenance.

## Field-level rule

The durable aesthetic rule extracted from TX-001 is:

> **Texture should emerge from sequential media transformations. Preserve differential treatment of structure and color. Corrections may precede degradation, and inherited errors should be allowed to become the input signal of later stages.**

This rule belongs at the Field Signature level because it is independent of subject, location, casting, and composition.

## Open question

The first parked extension is TX-002:

> Does explicit composite-signal simulation produce a perceptually meaningful improvement over the FFmpeg-only approximation?

See: https://github.com/rkankam/vfx/issues/1
