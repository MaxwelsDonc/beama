#!/bin/bash
# 把指定目录内所有 PDF 的每页渲染为 preview-<doc>-pN.png（供 agent 目检版式）
# 用法: ./scripts/preview.sh talks/<name>
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"

if [ $# -ne 1 ]; then
  echo "用法: $0 <目录>" >&2
  exit 1
fi
dir="$1"
[ -d "$dir" ] || dir="$ROOT/$dir"
if [ ! -d "$dir" ]; then
  echo "错误: 目录不存在: $1" >&2
  exit 1
fi

python3 - "$dir" <<'PY'
import os, sys
import fitz

dirpath = sys.argv[1]
pdfs = sorted(f for f in os.listdir(dirpath) if f.endswith(".pdf"))
if not pdfs:
    sys.exit(f"错误: {dirpath} 下没有 PDF，请先运行 build.sh")
for f in pdfs:
    doc = f[:-4]
    d = fitz.open(os.path.join(dirpath, f))
    for i, page in enumerate(d, 1):
        out = os.path.join(dirpath, f"preview-{doc}-p{i}.png")
        page.get_pixmap(matrix=fitz.Matrix(2, 2)).save(out)
    print(f"{f}: {len(d)} 页 -> preview-{doc}-pN.png")
PY
