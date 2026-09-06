#!/usr/bin/env bash
set -euo pipefail

# TX-001 — accepted proof pipeline
#
# Usage:
#   ./pipeline.sh input.mp4 output.mp4
#
# This script intentionally preserves the exact accepted parameter values from
# the 2026-09-06 experiment. Treat changes as a new experiment/preset version.

if [[ $# -ne 2 ]]; then
  echo "usage: $0 INPUT.mp4 OUTPUT.mp4" >&2
  exit 64
fi

IN="$1"
OUT="$2"
FFMPEG="${FFMPEG:-ffmpeg}"

if [[ ! -f "$IN" ]]; then
  echo "input not found: $IN" >&2
  exit 66
fi

TMP_DIR="$(mktemp -d)"
GEN="$TMP_DIR/analog_generation_ref.mpg"
trap 'rm -rf "$TMP_DIR"' EXIT

# Generation 1
#
# Semantic role:
#   electronic/camera detail enhancement
#   -> low-resolution signal
#   -> asymmetric luma/chroma bandwidth loss
#   -> chroma misregistration
#   -> modest signal noise
#   -> codec generation loss
"$FFMPEG" -y -v warning -i "$IN" \
  -map 0:v:0 -an \
  -vf "format=yuv444p,unsharp=lx=11:ly=11:la=2.25:cx=5:cy=5:ca=0,scale=288:512:flags=bicubic,gblur=sigma=0.50:planes=1,gblur=sigma=2.15:planes=6,chromashift=cbh=3:cbv=0:crh=1:crv=0:edge=smear,noise=c0s=6:c0f=t:c1s=3:c1f=t:c2s=3:c2f=t,format=yuv420p" \
  -c:v mpeg2video \
  -q:v 8 \
  -r 30 \
  "$GEN"

# Generation 2 / capture + delivery
#
# Semantic role:
#   decode inherited errors
#   -> reconstruct to delivery dimensions
#   -> weak later digital sharpening
#   -> H.264 delivery encode
#
# Audio is taken from the untouched source and re-encoded separately.
"$FFMPEG" -y -v warning \
  -i "$GEN" \
  -i "$IN" \
  -map 0:v:0 \
  -map 1:a? \
  -vf "scale=512:910:flags=bicubic,unsharp=lx=5:ly=5:la=0.45:cx=5:cy=5:ca=0,format=yuv420p" \
  -c:v libx264 \
  -preset slow \
  -crf 24 \
  -movflags +faststart \
  -c:a aac \
  -b:a 160k \
  -shortest \
  "$OUT"

printf 'TX-001 output: %s\n' "$OUT"
