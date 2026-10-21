# 学术汇报幻灯片设计模式调研（视觉参考拆解）

> 调研日期：2026-09-13。
> 方法：搜索公开 PDF 直链 → 下载（失败 2 次即放弃该来源）→ PyMuPDF 2x 渲染典型页 → 逐张目检后归纳。
> 注：原始 deck 与截图不随本仓库分发，请按下表来源 URL 自行获取；文中"第 N 页"均指原 deck 的页码。
> 口味基准：克制、排版驱动、不花哨（与现有 beamer 模板的 Anthropic 风格一致）。

---

## 1. Deck 清单（6 份有效）

| # | slug / 文件 | 来源 URL | 作者 / 场合 | 代表页 | 一句话评价 |
|---|---|---|---|---|---|
| 1 | `cs231n-lecture2` | https://cs231n.stanford.edu/slides/2024/lecture_2.pdf | Stanford CS231n 2024，Fei-Fei Li / Ehsan Adeli | CS231n 第 1、5、13 页 | 白底 + 深红底条的"教务规范型"，图片页的纪律性（整页一主题、逐图署名）是范本 |
| 2 | `cs285-policy-gradients` | https://rail.eecs.berkeley.edu/deeprlcourse/static/slides/lec-5.pdf | UC Berkeley CS285，Sergey Levine | CS285 第 1、5、9 页 | 全场最克制的一份；公式推导页的排版可直接当教科书 |
| 3 | `cs336-architectures` | https://github.com/stanford-cs336/spring2025-lectures（`nonexecutable/2025 Lecture 3 - architecture.pdf`，经 jsdelivr gcore 镜像） | Stanford CS336 Spring 2025，Tatsu Hashimoto | CS336 第 1、5、9、15、21 页 | 单蓝色 + 顶部色条，"提问式标题"；信息密度高但靠加粗和留白控节奏 |
| 4 | `dlsys-autodiff` | https://dlsyscourse.org/slides/4-automatic-differentiation.pdf | CMU 10-414/714 DLSys，Tianqi Chen / Tim Dettmers | DLSys 第 1、5、13、17 页 | 极简之最（仅一个深蓝标题色）；代码页三栏对照是本次调研最大单点收获 |
| 5 | `iit-indirect-object-identification` | https://arxiv.org/pdf/2211.00593 | Wang et al. 2022《Interpretability in the Wild》（Chris Olah / Circuits 学派） | IIT 论文 第 1、4、18 页 | "直接标注式图表"的教科书；每个实验固定"示意图 + 结果热图"成对出现 |
| 6 | `mit-6s191-deep-rl` | https://introtodeeplearning.com/slides/6S191_MIT_DeepLearning_L5.pdf | MIT 6.S191，Alexander Amini（2026-01 Deep RL 讲） | MIT 6.S191 第 1、15、35 页 | 暗色封面 + 白底内容 + 品牌页脚；对比卡片的"高亮当前 / 压暗其余"手法出色（注：文件名早期误标 transformers，内容实为 RL 讲座，已更正） |

### 放弃的来源与原因（尽力而为记录）

- **Anthropic 官方/研究员 talk slides（优先级 1）**：未找到公开 PDF。transformer-circuits.pub 全部内容均为 HTML 文章，无 slides 版本；Bing 定向搜索（含 filetype:pdf、site 限定）均无结果。
- **Chris Olah / Distill 的 slides 本体（优先级 2）**：distill.pub 只有 HTML 文章，无 PDF；以同图表语言的 IIT 论文（条目 5）代替，满足"含大量图表的论文页截图即可"的要求。
- **NeurIPS/ICLR invited talks（优先级 3）**：Bing 两轮搜索均无公开 slides 直链（会议官网只列标题）。LeCun《A Path Towards AMI》已从 arXiv 撤稿（ID 被他人论文复用），OpenReview 直链 403。
- **Karpathy 教程 deck（优先级 4）**："Let's build GPT / GPT-2" 仅视频无 PDF；CS231n 2016/2017 的 Karpathy 时代 slides 在 stanford.edu 上经 3 次尝试（https 全量、断点续传、http/1.1）均拿到截断/损坏文件，放弃。以 CS231n 2024 代替。
- **3Blue1Brown**：纯视频，无静态 deck。
- **rasbt《LLMs from Scratch》slides**：GitHub 仓库（github.com 与 raw.githubusercontent.com 在本网络不可达，jsdelivr 镜像可用）中 ppt 目录已无 PDF 文件，疑似作者移除。
- **Fei-Fei Li 个人 keynote**：未找到公开 PDF；以她参与的 CS231n 2024 代替。

---

## 2. 跨 deck 设计模式清单（12 条）

### M1 单强调色贯穿全 deck
- 证据：CS336 的天蓝（CS336 第 5 页 顶条+标题）、CS231n 的深红（CS231n 第 1 页 底条）、DLSys 的深蓝（DLSys 第 13 页 标题）、MIT 的品牌红（MIT 6.S191 第 15 页）。
- 为什么高级：色彩预算极省（全 deck 1 个彩色色相），信息层级交给字重和留白完成；观众的注意力全部留给内容。

### M2 细色条做品牌锚点，不占版面
- 证据：CS336 顶部一条纯色细带（第 5/15/21 页），CS231n 底部深红条内嵌"作者 | 页码 | 日期"（CS231n 第 13 页）。
- 为什么高级：一条 10-20pt 的色带就解决了"这是谁/第几页/什么场合"三个问题，比 logo 水印和页眉文字都安静。

### M3 标题即断言或问题
- 证据：CS336"Why RMSNorm?"（CS336 第 15 页）、"Architecture variations.."（`p09.png`）；CS285"Direct policy differentiation"（CS285 第 5 页）；DLSys"Reverse mode AD by extending computation graph"（DLSys 第 17 页）。
- 为什么高级：标题承担论点职能，翻页即得上下文；目录式标题（"第 3 节：方法"）在这些标杆里几乎绝迹。

### M4 正文层级只靠字重，不再加色
- 证据：CS336 `p15.png` 正文"**Fewer operations** / **Fewer parameters**"粗体引领，`p09.png` 右侧"Notable models:"粗体小标题；CS231n CS231n 第 5 页 当前模块黑、其余模块灰（灰度也是"字重"的一种）。
- 为什么高级：颜色数量恒定，层级深度却可以很陡；避免了"彩虹 bullet"的廉价感。

### M5 公式内彩色下划线标注推导步骤
- 证据：CS285 第 5 页——推导链中，本步被替换的项用蓝/橙色下划线标出（like-likelihood trick 一整页只看两条线就能跟上）；同页手写风红色箭头指出"当前讨论的是哪一项"（CS285 第 9 页 底部"what is this?"、DLSys 第 17 页 红箭头指向伪代码当前行）。
- 为什么高级：把"口播推导"转化为静态视觉引导，读者视线自然按替换链条移动；这是"高级感"最可操作的一条。

### M6 `recall:` 前缀召回旧公式，每页自足
- 证据：CS285 第 9 页 顶部以"recall: J(θ)=…"重新给出上页结论再开始新推导；CS336 `p15.png` 先复述再反驳（"Modern explanation — … Does this explanation make sense?"）。
- 为什么高级：学术汇报的听众注意力是断续的；每页自足让任意时刻入场的人都能跟上，同时制造"论证对话感"。

### M7 浅底圆角 callout 卡片放补充性质
- 证据：CS285 第 5 页 右侧浅蓝圆角卡"a convenient identity"——主叙事线在左，补充工具在右，卡片带一点底色+圆角，与正文严格分离。
- 为什么高级：不打断主推导链条，又保留了严谨性（该给的 identity 不省）；卡片比例小（约 1/3 版宽），不会反客为主。

### M8 每个实验 = 示意图 + 结果图，成对出现
- 证据：IIT 论文 第 18 页 Figure 12/13 固定结构：(a) 极简示意图标出 K/V/Q 作用位置 → (b) path patching 结果热图；(a) 和 (b) 的视觉语言一致（同样的节点名 S2、END）。
- 为什么高级："怎么做"与"看到什么"一一对应，实验页不再需要大段文字解释；读者先在 (a) 建立预期，再在 (b) 验证。

### M9 直接标注式图表：标签写进图内，不设编号图例
- 证据：IIT 论文 第 4 页 Figure 2——token 序列直接标注"IO Mary（绿）/ S1 John（紫）/ S2 John / END IO（黄底）"，head 类别以彩色块+名称嵌入图内（Duplicate Token Heads / Induction Heads…）；图例只解释 Q/K/V 箭头符号，不解释类别颜色。这是 distill.pub / Chris Olah 图表语言的核心。
- 为什么高级：消灭"看图→找图例→回图"的视线往返；图上文字本身就是叙述。做图成本略高，但这是图表"贵气"的主要来源。

### M10 代码页 = 代码 + 图 + 执行状态，三栏对照，单页只走算法一步
- 证据：DLSys 第 17 页——左侧等宽伪代码（8 行），右侧计算图上用红色高亮"当前正在遍历的边"，左下角手绘风"状态框"（i=4, node_to_grad={2:[v̄₂→₄], 3:[v̄₃], 4:[v̄₄]}）展示循环当前变量的值；DLSys 第 13 页 先给多通路计算图，再逐行给定义。
- 为什么高级：复刻了" debugger 单步执行 "的体验；代码页的信息上限 = 一页一个断点。Karpathy 教程口碑同理（视频不可得，本页是其静态等价物）。

### M11 双卡片对比：当前项全亮，其余压暗
- 证据：MIT 6.S191 第 35 页——"Value Learning vs Policy Learning"双圆角卡，当前讲解的 Policy Learning 卡全白高亮，另一张压暗至 30% 明度；CS231n 第 5 页 课程大纲三列，已讲/未讲模块灰显，当前模块纯黑+箭头时间线。
- 为什么高级：用明度而非边框表达"现在讲哪"，是动画高亮的静态等价；在多路线内容（agenda、对比方法、实验变体）里通用。

### M12 整页大图一句话 + 逐图小字署名 + 页角引用
- 证据：CS231n 第 13 页——标题"Challenges: Deformation"一句话，其余版面给 4 张图，每张图下方 8pt 灰色署名（作者 + CC-BY 2.0 链接）；MIT 6.S191 第 15 页 RL 概念整页一张闭环图；CS336 `p15.png` 右下角页角引用"[Ivanov et al 2023]"。
- 为什么高级：一句话标题 + 全幅证据，是"一页一 takeaway"的严格版；署名与引用的小字是学术严谨性的视觉信号，成本极低。

---

## 3. 与我们模板的差距对照

我们现有约定：米白底 `#FAF9F5`、单陶土橙强调 `#D97757`、衬线标题 + 无衬线正文、断言式标题、三级字阶、双行卡片。

### 可直接吸收（与现有纪律兼容，按性价比排序）

1. **M5 公式内单强调色下划线标注推导** —— 陶土橙下划线天然适配米白底；CS285 已证明"一条下划线换一行口播"。实现成本低（beamer 里一个 `\color{clay}\underline{}` 宏即可），建议做成模板宏 `\stepmark{}`。
2. **M9 直接标注式图表** —— 与我们"排版驱动"的审美最契合的升级方向。建议写进作图规范：所有自绘图标签写进图内、不设编号图例；颜色类别 ≤3 类且与陶土橙同族。
3. **M6 `recall:` 前缀 + M7 callout 卡片** —— recall 前缀是纯内容纪律（约定层面）；callout 卡片可复用现有"双行卡片"样式，加浅底色变体即可（米色底上建议用 `#F0EBE2` 类浅卡其，比蓝/灰更贴品牌）。
4. **M10 代码页"单页一步"三栏对照** —— 代码页用等宽字 + 右侧图 + 当前步高亮（陶土橙）。我们的模板若有代码页样式，把"一页一个断点"写进示例。
5. **M2 底部元信息条** —— CS231n 式"作者 | 页码 | 日期"底条比顶条安静，与米白底兼容；建议做成可选项（会议内部汇报可开，对外报告可关）。
6. **M8 示意图+结果成对** 与 **M12 页角引用/图注署名** —— 均为约定层面的规范，直接进模板使用手册。
7. **M11 双卡片对比的压暗手法** —— 双行卡片已有同族基因，扩展出"亮/暗"两态即可覆盖 agenda、对比实验、路线选择页。

### 有冲突 / 仅作了解

- **MIT 的深色封面与暗色内容页**（MIT 6.S191 第 1 页）：与米白底冲突，仅作了解。可移植的不是深色，而是 M11 的"压暗非当前项"——在亮底上同样成立（CS231n 大纲页即是亮底范例）。
- **CS336 顶部蓝条 / CS231n 深红底条**（M2）：色相与陶土橙冲突，但"细条锚点"的手法可移植——若用，建议用陶土橙 10-20% 淡色或纯黑细条，避免再引入一个高饱和色。
- **标杆几乎全部无衬线**（CS285/CS336/DLSys/MIT 无一衬线）：我们的"衬线标题 + 无衬线正文"反而是差异化资产（更接近 Anthropic 品牌调性），**建议保留**。但字重体系应向 CS336 看齐：标题不用粗黑而用 medium/semibold，正文 regular + 关键词 semibold——衬线标题配粗黑会显"编辑部化"，配 medium 才显"品牌感"。
- **白底 vs 米白底**：六份标杆全是纯白底。米白 `#FAF9F5` 在投影仪上对比度略降，是我们的品牌选择，保留；但要注意正文灰度不要浅过 60% 黑，图表坐标轴用 40-50% 灰保证可读。
- **CS336 的"提问式标题"**（M3 变体）：与我们的"断言式标题"是两种正当风格。断言式更"结论先行"（适合论文汇报），提问式更" lecture 叙事 "（适合教学）。建议保持断言式为主，章节过渡页可偶尔用提问式制造呼吸。

---

### 附：分发说明

原始 6 份 deck PDF 与逐页截图**不随本仓库分发**（版权属于原作者与院校）。如需复核文中证据，请按 §1 表格的来源 URL 获取原 deck，文中"第 N 页"即其 PDF 页码。
