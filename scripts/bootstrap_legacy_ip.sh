#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DEST="$ROOT/third_party/Digilent-ZYBO"
REPO="https://github.com/Digilent/ZYBO.git"
COMMIT="834fd71ed0349b8be6594a75f63a5f0c1f6ba615"

if [[ -d "$DEST/.git" ]]; then
  current="$(git -C "$DEST" rev-parse HEAD)"
  if [[ "$current" == "$COMMIT" ]]; then
    echo "Digilent/ZYBO legacy reference already pinned at $COMMIT"
    exit 0
  fi
  git -C "$DEST" fetch origin "$COMMIT"
  git -C "$DEST" checkout --detach "$COMMIT"
  exit 0
fi

mkdir -p "$(dirname "$DEST")"
git clone --filter=blob:none --no-checkout "$REPO" "$DEST"
git -C "$DEST" sparse-checkout init --cone
git -C "$DEST" sparse-checkout set Projects/hdmi_out Projects/hdmi_in Projects/dma Resources
git -C "$DEST" checkout --detach "$COMMIT"

echo "Pinned Digilent/ZYBO legacy reference at $COMMIT"
