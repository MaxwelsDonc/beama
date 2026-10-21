#!/usr/bin/env python3
"""扫描 PDF，报告超出安全边距的文字（像素级溢出检测）。
用法: python3 scripts/check_overflow.py talks/<name>/main.pdf
有溢出退出码 1，无溢出退出码 0。"""
import sys
import fitz  # PyMuPDF

X_MARGIN_PT = 6   # 水平安全边距
Y_MARGIN_PT = 2   # 垂直安全边距

def main(path: str) -> None:
    doc = fitz.open(path)
    problems = 0
    for pno, page in enumerate(doc, 1):
        safe = fitz.Rect(
            page.rect.x0 + X_MARGIN_PT, page.rect.y0 + Y_MARGIN_PT,
            page.rect.x1 - X_MARGIN_PT, page.rect.y1 - Y_MARGIN_PT,
        )
        for w in page.get_text("words"):
            r = fitz.Rect(w[:4])
            if r.width > 1 and not safe.contains(r):
                problems += 1
                print(f"[P{pno}] 溢出: \"{w[4]}\" "
                      f"bbox={tuple(round(v, 1) for v in w[:4])}")
    if problems:
        print(f"\n共 {problems} 处溢出")
        sys.exit(1)
    print("溢出检测通过：无文字越界")
    sys.exit(0)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        sys.exit(__doc__)
    main(sys.argv[1])
