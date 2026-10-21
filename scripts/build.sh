#!/bin/bash
# 构建 + 溢出检测
# 用法:
#   ./scripts/build.sh                # 回归构建 talks/_template（骨架即回归目标）
#   ./scripts/build.sh talks/<name>   # 构建指定目录下所有含 \documentclass 的 .tex
#   ./scripts/build.sh talks/x talks/y  # 可传多个目录
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"

build_dir() {
  local dir="$1"
  if [ ! -d "$dir" ]; then
    echo "错误: 目录不存在: $dir" >&2
    exit 1
  fi
  if [ ! -f "$dir/latexmkrc" ]; then
    echo "错误: $dir 缺少 latexmkrc（新汇报请用 ./scripts/new_talk.sh <name> 生成）" >&2
    exit 1
  fi
  local found=0 tex doc
  for tex in "$dir"/*.tex; do
    [ -e "$tex" ] || continue
    grep -q '\\documentclass' "$tex" || continue   # 跳过被 \input 的内容片段
    found=1
    doc="$(basename "$tex" .tex)"
    echo "== 构建 $doc ($dir)"
    ( cd "$dir" && latexmk -r latexmkrc "$doc.tex" )
    python3 "$ROOT/scripts/check_overflow.py" "$dir/$doc.pdf"
  done
  if [ "$found" -eq 0 ]; then
    echo "错误: $dir 下没有含 \\documentclass 的 .tex" >&2
    exit 1
  fi
}

if [ $# -eq 0 ]; then
  build_dir "$ROOT/talks/_template"
else
  for target in "$@"; do
    # 支持相对仓库根或相对当前目录两种写法
    if [ -d "$target" ]; then
      build_dir "$target"
    else
      build_dir "$ROOT/$target"
    fi
  done
fi
