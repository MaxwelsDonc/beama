#!/bin/bash
# 从 talks/_template 脚手架一个新汇报目录
# 用法: ./scripts/new_talk.sh <talk-name>   例: ./scripts/new_talk.sh 2026-09-group-meeting
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"

if [ $# -ne 1 ]; then
  echo "用法: $0 <talk-name>" >&2
  echo "例:   $0 2026-09-group-meeting" >&2
  exit 1
fi

name="$1"
case "$name" in
  */*|.*|_*)
    echo "错误: 名称 '$name' 不合法（不能含 '/'、不能以 '.' 或 '_' 开头，'_' 前缀保留给模板）" >&2
    exit 1 ;;
esac

dest="$ROOT/talks/$name"
if [ -e "$dest" ]; then
  echo "错误: talks/$name 已存在" >&2
  exit 1
fi

cp -R "$ROOT/talks/_template" "$dest"
# 脚手架只带源文件；清掉模板目录里可能存在的构建产物
rm -f "$dest"/*.aux "$dest"/*.log "$dest"/*.nav "$dest"/*.out "$dest"/*.snm \
      "$dest"/*.toc "$dest"/*.fdb_latexmk "$dest"/*.fls "$dest"/*.xdv \
      "$dest"/*.synctex.gz "$dest"/*.pdf "$dest"/preview-*.png 2>/dev/null || true
# 图片资产约定：所有插图放这里，main.tex 里 \includegraphics{figures/xxx.pdf} 引用
mkdir -p "$dest/figures"

echo "已创建 talks/$name/"
echo "下一步:"
echo "  1. 编辑 talks/$name/main.tex（元信息 + 正文）"
echo "  2. 把插图的 PDF 版放进 talks/$name/figures/（矢量优先，如 plot.pdf）"
echo "  3. ./scripts/build.sh talks/$name   # 构建并做溢出检测"
