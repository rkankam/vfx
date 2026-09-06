# vfx

A small evidence-driven repository for reusable visual post-production primitives.

The repository is not organized around labels such as `VHS`, `retro`, or `vintage`. The working rule is to model the transformations that a signal passes through and preserve only effects that survive an experiment.

## Core model

```text
SOURCE
→ ACQUISITION / CAMERA PROCESSING
→ CORRECTION
→ TRANSMISSION
→ STORAGE / COPYING
→ DECODING
→ DIGITAL CAPTURE
→ DELIVERY
```

A defect introduced at one stage becomes part of the signal consumed by the next stage. This makes sequencing more important than a final stack of decorative effects.

## Current proven primitive

### TX-001 — Edge halo / degraded electronic video

Status: **PROVEN**

TX-001 reproduces a useful electronic-video signature through a causal chain rather than a one-shot vintage filter:

```text
luma edge enhancement
→ low-resolution processing
→ mild luma bandwidth loss
→ stronger chroma bandwidth loss
→ chroma misregistration
→ MPEG-2 generation loss
→ upscale
→ weak secondary digital sharpening
```

The key visual contradiction is:

> **soft internal surfaces + exaggerated surviving contours + chroma spread**

See:

- `experiments/transmission-chain/TX-001-edge-halo/`
- `presets/tx_analog_edge_halo_v0.1.yaml`
- `docs/aesthetic-primitives/transmission-chain-as-aesthetic-system.md`
- `docs/experiment-closeout-protocol.md`
- `registry.yaml`

## Next unknown

TX-002 is parked as a bounded comparison: determine whether an explicit composite-signal stage such as `ntsc-rs` adds enough perceptual value over TX-001 to justify another dependency.

GitHub issue: https://github.com/rkankam/vfx/issues/1

## Evidence policy

This repository may be public while source/reference media can be private, licensed, copyrighted, or conversation-local. A proof therefore does **not** require republishing all media in Git.

When binary evidence should not be committed, preserve:

- exact filenames;
- SHA-256 digests;
- media metadata;
- exact executable commands;
- human validation result;
- explicit non-claims.

The media can later be placed in an authorized asset store and linked by manifest without rewriting the experiment history.

## Working rule

A successful experiment pays a capitalization tax before new exploration begins:

```text
REFERENCE
→ OBSERVE
→ HYPOTHESIZE CAUSAL CHAIN
→ REPRODUCE
→ HUMAN VALIDATION
→ FREEZE PROOF
→ EXTRACT INVARIANT
→ PACKAGE AS CONFIG
→ UPDATE FIELD KNOWLEDGE
→ PARK NEXT UNKNOWN
→ STOP
```
