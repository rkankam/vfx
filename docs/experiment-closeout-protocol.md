# Experiment Closeout Protocol

Status: active operating rule  
Origin: TX-001 closeout, 2026-09-06

## Purpose

A successful experiment is not finished when the output looks good.

It is finished when the result has been converted from temporary context into reusable operational heritage.

Without closeout, a later session remembers only:

> "we had found a good FFmpeg trick"

and must repeat the investigation.

The closeout protocol prevents that loss.

## Core loop

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

The final `STOP` is part of the protocol.

A discovery should not automatically authorize another exploration branch.

## Capitalization tax

Before a successful experiment may open a new branch of investigation, it should pay a **capitalization tax**.

The minimum tax is five objects.

### 1. Frozen proof

Preserve:

- experiment ID;
- original question;
- date;
- exact executable command(s);
- exact parameter values;
- input/output identity or checksums;
- human validation result;
- what was proven;
- what was not proven.

The proof should be immutable in meaning. Further tuning becomes another experiment or preset version.

### 2. Reusable preset / config

Extract the accepted parameterization into a machine-readable configuration.

The config should describe both:

```text
operator
+ semantic role
```

For example:

```text
unsharp(amount=2.25)
```

is weaker knowledge than:

```text
camera_detail_enhancement:
  operator: unsharp
  amount: 2.25
```

because later agents need to know **why** a stage exists before deciding whether to change it.

### 3. General invariant

Extract what survives beyond the specific source.

The invariant must sit between two bad abstractions:

```text
too specific:
"use exactly blur 2.15 on every video"

useful:
"degrade chroma more than luma for this signal family"

too vague:
"make it vintage"
```

The invariant is the main intellectual asset of the experiment.

### 4. Field integration

Write the smallest stable rule that belongs in higher-level aesthetic knowledge.

Do not paste implementation detail into the Field Signature Bible.

A Field rule should preserve:

- medium logic;
- perceptual signature;
- allowed imperfections;
- forbidden shortcuts;
- causal relationships that should survive tool changes.

### 5. Parked next unknown

Open exactly one bounded next question if an unresolved dependency is genuinely useful.

The issue should contain:

- question;
- reason it matters;
- minimal experiment;
- keep criteria;
- reject criteria;
- non-goals;
- start condition.

Then stop.

## Recommended repository packet

```text
experiments/
└── <family>/
    └── <EXPERIMENT-ID>-<slug>/
        ├── README.md
        ├── pipeline.sh
        └── evidence-manifest.yaml

presets/
└── <preset-id>.yaml

docs/
├── aesthetic-primitives/
│   └── <invariant>.md
└── experiment-closeout-protocol.md

registry.yaml
```

Binary evidence may live elsewhere when Git is not the correct storage layer. Preserve hashes and provenance in the experiment manifest.

## Proof language

Every closeout should separate three levels.

### Observed

What was directly visible in the reference or output.

### Experimentally reproduced

What the test chain demonstrably produced.

### Historical / causal attribution

What is believed to have caused the original reference.

A successful reproduction can validate a useful mechanism without proving historical attribution.

Example:

```text
OBSERVED:
bright/cyan contours around high-contrast subjects

REPRODUCED:
pre-sharpen + asymmetric bandwidth loss + chroma shift + generation loss
creates a similar perceptual family

NOT PROVEN:
the historical source definitely used VHS/composite/the same sharpening circuit
```

This distinction prevents aesthetically useful experiments from turning into false forensic claims.

## When to create a new experiment ID

Create a new experiment when changing any assumption that could alter the causal interpretation, such as:

- stage ordering;
- signal family;
- intermediate codec or recording model;
- working resolution class;
- composite encode/decode model;
- interlace/deinterlace behavior;
- display simulation;
- a new target fingerprint;
- a materially different hypothesis.

Minor parameter sweeps within the same hypothesis may remain under one experiment until a proof is accepted.

## When to version a preset instead

Version the preset when the causal chain remains the same but a reusable parameterization changes after qualification.

Example:

```text
TX-001 remains the evidence origin

 tx_analog_edge_halo_v0.1
 → tx_analog_edge_halo_v0.2
```

Only call a new preset `proven` after human validation.

## Stop conditions

Stop an experiment when:

- the target mechanism has been reproduced well enough to answer the question;
- the user has accepted the result;
- the remaining changes are taste/tuning rather than hypothesis tests;
- further exploration would introduce a new dependency or causal stage;
- the next unknown can be written as a separate issue.

Do not continue because:

- more knobs exist;
- another library looks interesting;
- a stronger degradation might be possible;
- the result could always be 3% closer.

## TX-001 closeout example

TX-001 paid the capitalization tax by producing:

```text
proof:
experiments/transmission-chain/TX-001-edge-halo/

preset:
presets/tx_analog_edge_halo_v0.1.yaml

invariant:
docs/aesthetic-primitives/transmission-chain-as-aesthetic-system.md

field integration snippet:
docs/field-signature-integration.md

next unknown:
TX-002 — https://github.com/rkankam/vfx/issues/1
```

The useful assets from the session are therefore not only the rendered video.

They are:

1. a validated perceptual mechanism;
2. a reusable technical primitive;
3. a higher-level aesthetic rule;
4. a reproducible evidence packet;
5. a bounded next question that does not consume attention yet.
