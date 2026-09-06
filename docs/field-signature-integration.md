# Field Signature Integration — Transmission-Chain Medium Rule

Status: ready to inject into relevant Field Signature Bibles  
Evidence origin: TX-001  
Date: 2026-09-06

## Why this is a Field-level rule

The TX-001 result is independent of subject, casting, location, object choice, or composition.

It describes how the **medium itself** should behave.

Therefore the durable part belongs in `Texture / Medium Rules`, while the exact FFmpeg implementation stays in the VFX repository.

## Recommended insertion

### Texture / Medium Rules

**Transmission-chain rule:**

Texture should emerge from sequential media transformations rather than a monolithic `vintage` filter. Preserve differential treatment of structure and color. Edge/detail enhancement may occur before bandwidth loss, allowing internal surfaces to become soft while artificial contours survive. Errors introduced by one generation should be allowed to become the input signal of later generations.

**Camera / signal logic:**

- electronic detail enhancement may exaggerate high-contrast boundaries before later degradation;
- luminance may retain more spatial definition than chrominance;
- pixel-scale defects should be created at the simulated working resolution rather than only at final delivery resolution;
- later capture/remaster/platform sharpening may act on artefacts inherited from previous stages;
- the desired texture may be a poor/processed signal without spectacular tape damage.

**Acceptable imperfections:**

- luma overshoot / edge ringing;
- light or cyan edge halos on high-contrast boundaries;
- chroma spread;
- slight chroma misregistration or delay;
- luma/chroma bandwidth asymmetry;
- generation loss;
- imperfect reconstruction / resampling;
- mild codec residue when causally placed in the chain;
- soft internal surfaces coexisting with over-insistent edges.

**Unacceptable imperfections / shortcuts:**

- generic VHS overlay used as the whole aesthetic;
- uniform blur applied equally to structure and color;
- decorative scanlines disconnected from display/signal logic;
- maximal tracking damage by default;
- random glitch used to imply age;
- modern clean image with grain/noise pasted on as the final layer;
- chromatic aberration used indiscriminately as a substitute for chroma bandwidth or registration defects;
- historical claims that are stronger than the evidence.

**Medium rule:**

> The image should feel as though it has survived a plausible chain of acquisition, correction, transmission, storage/copying, decoding, capture and delivery. The chain should explain the defects; the defects should not merely decorate the image.

## Anti-field addition

Useful anti-pattern sentence:

> Reject images where `vintage` is legible as a preset placed on top of a contemporary clean master rather than as a consequence of the medium's internal processing history.

## Selection criteria addition

A strong texture candidate should:

- contain at least one medium-specific contradiction, such as soft surfaces with hard electronic edges or stable luminance with loose chroma;
- preserve defects that imply process history rather than generic dirt;
- remain convincing when obvious nostalgia markers such as dates, logos, scanlines, or tape bars are removed;
- suggest that different parts of the signal have been treated differently.

Reject if:

- all defects can be described as global blur + noise + grain;
- the image depends entirely on an overlay to communicate age;
- the texture is visually loud but technically structureless;
- the media treatment overwhelms the world rather than carrying it.

## Implementation boundary

Do not copy the exact TX-001 FFmpeg numbers into the Field Signature Bible.

The Field Bible should retain the invariant. The executable implementation remains versioned here:

- `experiments/transmission-chain/TX-001-edge-halo/pipeline.sh`
- `presets/tx_analog_edge_halo_v0.1.yaml`

This separation allows the toolchain to change without rewriting the aesthetic definition.
