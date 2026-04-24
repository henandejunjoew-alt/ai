# CRANE_AI_NEXUS | 工程重构指令集 (Technical Manifesto)

## 1. 项目愿景 (System Identity)
* **定位**：起重机出口行业专属的 AI 指挥中控系统。
* **核心开发者**：Jesper Wu
* **风格指南**：Dark Tech (深邃科技)。UI 必须呈现出高精尖、情报化、工业感。
* **关键色值**：背景 `#020617` (Slate-950)，霓虹主题色 `Cyan-500` (主色)、`Emerald-500` (正向)、`Rose-500` (预警)。

## 2. 技术栈约束 (Tech Stack)
* **架构**：单文件大单体 (Monolith HTML)。
* **前端**：HTML5 + Tailwind CSS (CDN版) + Vanilla JavaScript。
* **API**：通过 Fetch 调用 OpenAI 兼容接口，使用 GPT-4o 模型。
* **数据流**：前端输入 -> AI 返回结构化 JSON -> 前端清洗 JSON 并动态渲染 DOM。

## 3. 核心重构任务：情报分析引擎 (Refactor: Logic & UI)
**【重要】此模块已由“评估”转向“情报”，必须执行以下修改：**

### A. 逻辑重构 (runDiagnosis Function)
1. **彻底移除评分**：禁止在 Prompt 中要求 `score` 字段，禁止在 UI 中展示百分比圆环或数值。
2. **强化字数与深度**：Prompt 必须强制要求 AI 对以下四个维度输出不少于 150 字的专业分析：
    - `background`: 实体背景与行业地位。
    - `finance`: 外汇储备、结算风险、信用证习俗。
    - `logistics`: 国际局势影响、特定港口装卸、HS编码税率。
    - `tactic`: 具体的谈判心理与商务切入战术。
3. **清洗逻辑**：由于 AI 可能会返回包含 Markdown 的 JSON，必须使用正则表达式清洗后执行 `JSON.parse`，并增加 `try-catch` 错误处理。

### B. UI 渲染重构 (Intelligence Dossier Style)
1. **布局调整**：将原来用于显示分数的空间释放，顶部展示实体名称及“情报标签云”。
2. **纵向卷宗感**：四个分析维度卡片改用单列纵向排列，以增强阅读深度。
3. **视觉反馈**：保留 `glass-card` 效果，并增加每张卡片左侧的动态色块（`border-l-4`）。

## 4. 视觉规范 (Visual Protocols)
* **Glassmorphism**：背景模糊 `backdrop-blur-xl`，边框 `border-white/10`。
* **网格系统**：背景必须保持 40px 的科技网格纹理。
* **滚动体验**：隐藏原生滚动条，仅保留自定义的微细滚动条。
* **动画**：加载时使用 `animate-spin`，数据载入时使用 `animate-fadeIn`。

## 5. 禁止事项 (Strict Prohibitions)
* **严禁**：引入 React/Vue/Svelte 等外部重量级框架。
* **严禁**：在代码中硬编码任何 API Key 或密码（必须从 DOM 动态读取）。
* **严禁**：使用任何柔和、明亮的色彩或卡通插画。
* **严禁**：AI 回复包含“作为一个AI...”等废话，必须保持冷酷、专业的情报员语气。

## 6. Claude Code 任务流 (Execution Steps)
1. **[Step 1]** 扫描整个 `index.html` 的 JavaScript 逻辑。
2. **[Step 2]** 修改 `runDiagnosis` 的 Prompt 内容，确保“只分析，不评分”。
3. **[Step 3]** 重写 `runDiagnosis` 内部的 `diagResult.innerHTML` 渲染代码，适配“情报卷宗”布局。
4. **[Step 4]** 优化错误处理，确保在 API 失败或 JSON 解析错误时，用户能看到专业的“[SYSTEM ERROR]”反馈。