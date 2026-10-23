# AGENTS.md — 本仓库的唯一入口文档

beamer 学术汇报模板（Beama 主题，中文名「增辉」——为你的研究增辉；16:9，XeLaTeX，中西文字体已随库打包）。
用户不手动操作本仓库：所有"做汇报 / 做 PPT / 改 slides"的需求都由 agent 按本指南完成。
本文件自包含；只有扩展主题时才需要读 `docs/design-spec.md`。

依赖：TeX Live（xelatex + latexmk）、python3 + PyMuPDF（缺则 `pip install pymupdf`）。

## 内容红线（最高优先级，凌驾于一切流程）

- **禁止虚构内容**：不得编造实验数字、测量声明、benchmark 结果、论文引用、
  来源署名。材料里没有的，一律用明显占位符（如 ``Your result here''）或向用户索要。
- 本生产线的输入是**用户的真实材料**；没有材料不许开工造内容。

## 设计变更流程（硬性顺序，禁止跳过）

1. **设计**：先做渲染预览稿（/tmp 或草稿页），不动 `theme/`；
2. **讨论**：与用户讨论设计稿；
3. **听众评价**：agent 扮演目标听众（会议参会者/组会同学），对预览稿做批判性评价；
4. **批准**：用户确认后才动手改 `theme/`，改完回归 + commit。

## 仓库地图

| 路径 | 作用 | 改动规则 |
|---|---|---|
| `theme/*.sty` | 主题：颜色 / 字体 / 版式与构件 | 只有改版式时才动；改完必须全量回归 |
| `fonts/` | 思源宋/黑（OFL）；西文用 TeX Live 内置 | 不动 |
| `talks/_template/` | 汇报骨架（全页型示例 + 写作注释）兼作构建回归目标：脚手架从这里拷贝，build.sh 无参回归也构建它 | 只通过 new_talk.sh 拷贝使用，不直接改来用 |
| `talks/<name>/` | 每次汇报一个目录（含 `figures/` 放插图，PDF 矢量优先） | 工作内容写在这里 |
| `scripts/new_talk.sh <name>` | 脚手架 | 不动，直接调用 |
| `scripts/build.sh [dir...]` | 构建 + 溢出检测；无参 = 回归构建 `_template` | 不动，直接调用 |
| `scripts/preview.sh <dir>` | 把目录内 PDF 渲染为 `preview-*-pN.png` | 不动，直接调用 |
| `scripts/check_overflow.py` | 文字越界检测（由 build.sh 调用） | 不动 |
| `docs/design-spec.md` | 设计依据 + 已规划未实现的页型 | 扩展主题前先读 |

## 标准流程（新汇报）

1. `./scripts/new_talk.sh <YYYY-MM-主题>`
2. 编辑 `talks/<name>/main.tex`：替换元信息，按骨架页型写正文（骨架注释即写作指南）。
3. `./scripts/build.sh talks/<name>` —— 自动跑溢出检测。
   **报红必须改文案或拆页，禁止靠缩字号硬塞。**
4. `./scripts/preview.sh talks/<name>`，然后 Read 关键页 PNG 自行目检：
   封面、第一个章节分隔页、内容最满的一页。
5. 交付：告知 PDF 路径 + 展示关键预览图。
   用户反馈"第 N 页 ……"→ 定位对应 frame 修改 → 重新 build + preview。
6. **收尾闭环**（交付后或用户说"复盘"时执行）：
   - 哪些页是"组合页"（无预置命令现场组装）→ 向用户提出固化建议；
   - 哪些规则被绕过/违反过 → 规则本身合理吗？改规则还是改主题？
   - 踩了什么新坑 → 沉淀为规则或处理阶梯新条目。
   结论写入 AGENTS.md 或 `theme/`，回归 + commit。旧 talk 保留在 talks/，
   改主题后连同 `_template` 一起重新构建，作真实回归。

## 硬性版式规则

- 帧标题写**结论句**（assertion），不写名词短语（topic）。
- 每页至多一处 clay 强调；`aaok`/`aabad` 仅用于 ✓/✗ 语义。
- 图文并排页必须 `\begin{columns}[T]`（大写 T 按列顶对齐；小写 t 按基线对齐，
  图片会把文字列压沉溢出页底——骨架注释里有说明）。
- `\card` 与 itemize 每条至多两行；写不下就拆页。
- 图 / 数据出处一律 `\aasource{...}` 放页底；插图的 PDF 矢量版放项目目录 `figures/` 下引用。
- **recall 前缀**（M6）：新页开头召回上页结论，用 frame 的副标题参数承载——
  `\begin{frame}{标题}{recall: ...}`。注意：正文若以 `{}` 组开头会被 beamer 误吞成副标题。
- **自绘图表直接标注**（M9）：标签写进图内、不设编号图例；类别色 ≤3 且与
  陶土橙同族（`aaclay`/`aaclaytint`），辅助信息用 `aastone`。骨架图文页有样例。
- **实验页成对**（M8）：示意图 + 结果图成对出现；每图逐图署名，页角引用（M12）。
- **推导页**（M5）：`\stepmark{本步被替换的项}`，视线跟着替换链走；补充 identity 放 `aacallout`。
- **对比/议程页**（M11）：当前项 `\card` 全亮，其余 `\carddim` 压暗；版式用
  **ours 横幅卡置顶 + 2×2 压暗等高网格**，不要三列插花。
- **对齐纪律（方块一致）**：并排卡片必须等高——同行卡片传相同组名
  `\card[group=r1]`（tcolorbox equal height group，跨栏生效）；TikZ 链条图的
  节点统一 `text width=<宽>,align=center`（盒宽由文本宽决定，不被内容撑变形；
  `below=of` 定位需 positioning 库，骨架已加载）；宽高比悬殊的双图用
  `\figpair[height=4.2cm,...]` 高度约束，不用宽度约束。
- **表格**（booktabs，主题已加载）：三细线（`\toprule/\midrule/\bottomrule`）、**永禁竖线**；
  clay 只标每列最优值；数字小数点对齐。
- **图片页**：`\fullfig{文件}{takeaway}`（整页大图，必带一句加粗 takeaway）；
  `\figpair{A}{标A}{B}{标B}`（双图成对）。两者内置 keepaspectratio——图只会缩小、永不溢出。
- 版式修改只发生在 `theme/*.sty`（所有汇报共享），禁止在某个 talk 的
  main.tex 里堆一次性样式 hack。
- `main.tex` 开头的"模板接线"区（`\aaFontPath`、`\usetheme`）与 `latexmkrc`
  保持原样。

## 放不下时的处理阶梯（按顺序尝试，禁止直接跳到最后硬缩）

- **表格太宽**：减列/合并 → 转置 → 拆两页 → 细节进 backup → 最后才 `\resizebox`
  （等效字号不得低于 `\footnotesize`）。
- **表格太长**：只放 top-N 行 + 一行"完整版见 backup"，完整表进附录。
- **图片太大**：`keepaspectratio` 已兜底（图只会变小、不会溢出）；小到看不清 →
  裁局部放大，或改用整页大图页。
- **图片太宽**：放弃图文并排，直接 `\fullfig` 整页大图页。
- 构建后溢出检测报红 = 必须回到本阶梯逐项尝试；禁止给正文 `\small` 硬塞。

## 页型裁决规则（滚动进化，禁止预置穷举清单）

1. 有预置命令/模式的页型，**必须**用预置机制（见构件速查）。
2. 无预置命令的页型：用基础元素（columns/itemize/enumerate/tcolorbox/tabular/TikZ）
   按本文纪律组装；交付说明里**标记该页为"组合页"**，并询问用户是否固化。
3. 同一类组合页型第二次被自然使用 → 固化进 `theme/*.sty`，回归后更新构件速查。

## 叙事预算（20 分钟会议汇报基准）

- 总页数 18–24（含 backup）；正文节奏约 1 分钟/页。
- 时间配比：问题与动机 ~20% / 方法 ~40% / 结果 ~30% / 总结 ~10%。
- 一页一个 takeaway；讲不动的细节一律进 `\appendix` backup。
- 章节 3–4 个，每章节正文 ≤6 页；宁可拆页，不缩字号。
- 显式目录页：≥30 分钟或章节 ≥5 时保留；否则删除（导航由章节分隔页的 mini-TOC 承担）。

## 构件速查

| 命令 / 环境 | 用途 |
|---|---|
| `\card{名称}{一行注释}` | 双行卡片（`[group=名]` 同行等高） |
| `\carddim{名称}{注释}` | 压暗态卡片（议程/对比页"非当前项"，M11；支持 `[group=]`） |
| `\stepmark{项}` | 推导式内陶土橙下划线，标出"本步被替换的项"（M5） |
| `\begin{aacallout}[标题]` | 浅底圆角补充卡：identity/备注，不打断主叙事（M7） |
| `\aasource{...}` | 页底灰色小字来源标注 |
| `\aathanks{Thank You!}{邮箱/备注}` | 致谢 / Q&A 页（与封面互为书挡） |
| `\begin{block}{Theorem 1}...\end{block}` | 定理 / 推导（claytint 浅底） |
| `\fullfig{文件}{takeaway}` | 整页大图页（keepaspectratio 防溢出，M12） |
| `\figpair{A}{标A}{B}{标B}` | 双图成对自动 (a)/(b)；`[h=高]` 等高约束、`[pageA/pageB=n]` 多页 PDF（M8） |
| `booktabs` 表格 | `\toprule/\midrule/\bottomrule` 三细线，禁竖线，clay 标最优 |
| TikZ 样式 `aanode/aaactive/aaedge/aahighlight/aalabel` | 自绘示意图的冻结视觉语言（M9），不现场定义样式 |
| `\aaSetBackground{white\|ivory}` | 背景变体：老投影仪偏色时切白底（默认 ivory） |
| `\appendix` 之后的 frame | 备份页（不进主叙事） |
| `\aaSetFrametitle{clayrule\|thinline}` | 帧标题下划线样式（默认 clayrule） |
| `\aaSetSectionpage{on\|off}` | `\section` 自动章节分隔页开关（默认 on） |
| `\begin{frame}{Outline}\tableofcontents[hideallsubsections]\end{frame}` | 目录页 |

颜色：`aaivory`（帧底）/ `aaink`（正文）/ `aastone`（次要）/ `aaclay`（唯一强调）/
`aaclaytint`（强调浅底）/ `aalinen`（分隔线）/ `aaok` / `aabad`。

## 扩展主题时

新页型或改版式：先读 `docs/design-spec.md`（设计意图溯源）与
`docs/reference/findings.md`（6 份 AI 标杆 deck 的设计模式拆解 M1–M12；原 deck 与截图不随仓库分发，来源 URL 见文内清单），
在 `theme/` 中实现，然后 `./scripts/build.sh`（无参，回归 `_template`）验证。
