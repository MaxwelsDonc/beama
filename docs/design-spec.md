# Anthropic 风学术 Beamer 通用模板 — 设计文档

日期：2026-08-08（2026-10-21 随 Beama 开源刷新）
状态：已落地——主题与构件全部实现；§5 中标星页型为规划未实现，留作 roadmap

## 1. 目标与定位

打造一个**通用的学术演示 Beamer 主题**（非一次性 PPT），覆盖组会、会议报告、答辩、课程讲座等全部学术场景。视觉语言参考 Anthropic 品牌风格（暖米白、陶土橙、编辑感排版），并将用户在博士答辩 PPT 项目中形成的设计偏好机制化。

核心诉求：**高信息密度但高度有序**——反对"页数多、单页信息量低"，每页必须值回版面。

## 2. 技术路线

- 自建主题包（Beamer 标准四组件结构），`\usetheme{...}` 即可复用
- 编译引擎：XeLaTeX（中英混排刚需）+ latexmk
- 关键宏包：fontspec、xeCJK/ctex、unicode-math、tcolorbox、TikZ、minted、biblatex
- 环境已验证：TeX Live 2026（macOS），xelatex/latexmk/minted/biblatex/ctex 均可用

## 3. 配色系统（单色纪律，无章节色）

Anthropic 基因：暖米白底、暖炭黑文字、陶土橙点缀。

| 角色 | 色值 | 用途 |
|---|---|---|
| 底色 ivory | `#FAF9F5` | 帧背景 |
| 主文字 ink | `#1F1E1C` | 正文、标题 |
| 次要文字 stone | `#6E6A61` | 注释行、脚注、次级信息 |
| 全局强调 clay | `#D97757` | 每页至多一处：关键词、进度条、强调元素 |
| 强调浅底 claytint | `#F9EFE7` | 卡片底色、强调框背景 |
| 分隔线 linen | `#E3E0D8` | 细线、卡片描边、表格线 |
| 语义 ok | `#4E7A44`（灰绿） | 仅 ✓ |
| 语义 bad | `#B3492E`（灰红） | 仅 ✗ |

纪律（机制强制）：
- 全文仅 clay 一个强调色，禁止第二强调色
- 禁止实心重色标题条；注释统一浅底
- 绿/红只作 ✓/✗ 语义，不作装饰

## 4. 字体系统

**衬线标题 + 无衬线正文**（Anthropic 式编辑感）。硬指标：**中英混搭时双方气质一致**——衬线对衬线、无衬线对无衬线，字重与视觉字号对齐（西文字体看似"同 pt 不同大"，需按 x-height/字面微调缩放比例）。

| 角色 | 西文 | 中文 | 备选（缺字体时） |
|---|---|---|---|
| 标题 | Source Serif 4 / Libertinus Serif | 思源宋体 (Source Han Serif SC) | 苹方/宋体-简 |
| 正文 | Source Sans 3 | 思源黑体 (Source Han Sans SC) | 苹方 |
| 数学 | STIX Two Math（unicode-math） | — | Libertinus Math |
| 代码 | JetBrains Mono / Source Code Pro | — | Fira Mono |

三级字阶（用户既有纪律，真实印刷大小）：
- L1 标题：彩色或深色粗体
- L2 正文：常规
- L3 注释：stone 灰色小字

Stage 1 必须验证：中英混排行内对齐（baseline）、标题行中英字重观感一致性。

## 5. 页面系统（4 组 10 种框架，全部命令化）

### 门户页
1. **封面页** `\maketitle`：题目+报告人+单位+logo，大留白，clay 点缀
2. **章节过渡页**：`\section` 自动触发，大号编号 + 章节名 + 本章目录提示

### 内容主体页
3. **标准内容页**：断言式标题（标题即结论句）+ 单栏正文
4. **图文对照页**：双栏（左右比例可调），栏间等高
5. **全幅图页** `\fullfig{...}`：大图满版，仅留标题与一行注释
6. **推导/定理页**：tcolorbox 定理环境 + `\keyeq{}` 公式高亮框

### 叙事强化页
7. **金句页** `\keymessage{...}`：整页一句话/一个数字，居中大字
8. **技术路线页**：预定义 TikZ 流程/时间线样式
9. **对比页** `\vs{A}{B}`：双卡片对照

### 收尾页
10. **总结/致谢页**：编号式要点列表；变体：Q&A、参考文献、backup 附录

## 6. 偏好机制化清单（来自答辩 PPT 项目）

| 偏好 | 机制 |
|---|---|
| 双行卡片（粗体名称行+灰注释行） | `\card{名称}{注释}`，卡片自动等高 |
| 设问芯片 | `\mainquestion{...}`（白色 chip + 虚线引导） |
| 直角走线、箭头带杆身（≥0.52cm）、禁斜线 | 预定义 TikZ 箭头/连线样式 |
| 三级字阶、灰色注释 | beamer 字体模板固定 |
| 编号不重复（「③ 路径A」式） | 写作规范约定 |
| 栏间等高、消灭大片空白 | columns 模板 + tcolorbox equal height |
| 像素级溢出检测 | `scripts/check_overflow.py`（PyMuPDF 扫描文字 bbox，编译后自动跑） |
| 断言式标题 | 写作规范 + demo 示范 |

## 7. 项目结构

```
beama/
├── theme/                      # 主题包（可 symlink 到 TEXMFHOME 全局复用）
│   ├── beamerthemebeama.sty          # 主入口 + 自定义命令
│   ├── beamercolorthemebeama.sty     # 色板与 beamer 色彩映射
│   └── beamerfontthemebeama.sty      # 中西文字体与三级字阶
├── fonts/                      # 思源宋/黑 SC（OFL 1.1，随仓库分发）
├── talks/_template/            # 汇报骨架（全页型示例 + 写作注释），兼作构建回归目标
├── scripts/
│   ├── new_talk.sh             # 脚手架：拷贝 _template 生成 talks/<name>/
│   ├── build.sh                # latexmk + xelatex（-shell-escape）+ 溢出检测
│   ├── preview.sh              # PDF → 逐页预览 PNG（供目检）
│   └── check_overflow.py       # PyMuPDF 溢出检测
└── docs/
    ├── design-spec.md          # 本文档（设计依据）
    └── reference/findings.md   # 6 份标杆 deck 的设计模式拆解（M1–M12）
```

## 8. 执行路径（五阶段）

- **Stage 1 视觉打样**：只做封面 + 1 个标准内容页 → 编译 PDF → 用户对齐审美（配色、字体、中英混搭一致性）。最大风险点最先验证，可能迭代 1–2 轮
- **Stage 2 主题骨架**：四组件主题文件 + 编译工具链（latexmkrc、build.sh）
- **Stage 3 页面系统**：10 种框架逐个实现，demo.tex 每种一页样张
- **Stage 4 真实回归**：从用户博士答辩 PPT 选 3 个代表页（金句页、对比页、双行卡片列表页）翻译为 beamer，对比验收
- **Stage 5 收尾**：写作规范文档 + 溢出检测接入构建流程

每阶段产出可编译、可看的实物；视觉问题在 Stage 1 暴露，不留到后期。

## 9. 验收标准

- `\usetheme{beama}` 即可在新文档中使用全部功能
- `talks/_template/` 骨架一键编译通过（XeLaTeX），全部页型示例齐全
- 中英混排行内 baseline 对齐，标题中英字重观感一致
- 溢出检测脚本对骨架 PDF 扫描零告警
- 回归页与答辩 PPT 原版对比，信息密度与秩序感不降级

## 10. 风险与对策

| 风险 | 对策 |
|---|---|
| 本机缺思源/ Source 系列字体 | Stage 1 先探测字体，回退苹方/系统字体并记录 |
| minted 需 `-shell-escape` | build.sh 默认带该参数；备选 listings |
| 米白底在某些投影仪偏色 | Stage 1 打样确认；必要时提供白底变体选项 |
| 衬线数学符号风格冲突 | unicode-math 统一 STIX Two Math，避免默认 CM 混搭 |
