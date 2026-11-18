# 参考文件模块化切分 · 说明

把 `E:\IC\Code\Skill\Done\Pcell\Inductor\DiffAmpPcell_T28.il` 按仓库
（[GUIYunLing/Virtuoso-Skill-Pcell](https://github.com/GUIYunLing/Virtuoso-Skill-Pcell)）
的 `dfInd_m1..m7` 风格切成 13 个模块。

**参考文件未做任何修改**，仍是 1642 行 / 70966 B / CRLF。

---

## 一、切分结果

| 模块 | 原行号 | 行数 | 字节 | 内容 |
|---|---|---|---|---|
| `ref_m1_entry.il` | 1–9 | 9 | 110 | 文件头 + `DiffAmpPcell` 入口 |
| `ref_m2_util.il` | 10–26 | 17 | 501 | `SnapToMinSpacing` 网格吸附 |
| `ref_m3_cdf.il` | 27–73 | 47 | 959 | `PcellCdf` 建 CDF 参数 |
| `ref_m4_callback.il` | 74–236 | 163 | 4068 | `CallBack` 参数钳制（三段平铺） |
| `ref_m5_engine.il` | 237–272 | 36 | 1887 | `PcDefine` 头 + `let` 声明 50 个局部变量 |
| `ref_m6_case7.il` | 273–656 | 384 | 17682 | `case Tr=7` 全段 |
| `ref_m7_case6.il` | 657–665 | 9 | 83 | `case Tr=6` error 分支 |
| `ref_m8_case5.il` | 666–1025 | 360 | 17113 | `case Tr=5` 全段 |
| `ref_m9_case4.il` | 1026–1030 | 5 | 65 | `case Tr=4` error 分支 |
| `ref_m10_case3.il` | 1031–1245 | 215 | 10047 | `case Tr=3` 全段 + `);case` |
| `ref_m11_route.il` | 1246–1436 | 191 | 10667 | M5/M4/M3 引出 + VIA5/VIA3/VIA4 阵列 |
| `ref_m12_pin.il` | 1437–1617 | 181 | 7568 | Horizontal 重建 + figGroup + 端子 P1~P10 |
| `ref_m13_tail.il` | 1618–1643 | 25 | 192 | 授权 `else` 分支 + 括号闭合 |

> m13 的行范围写作 1618–1643，是因为 `split(b"\r\n")` 在文件末尾多产生一个空元素
> （文件以 CRLF 结尾）。该元素不是真实行，真实行数为 25。

**重建验证**：按上表顺序拼接，与原文件**逐字节一致**
（sha256 `483f3228497debcaae7617c2eb0a7b18ca1eb0bf30e9412b7b0274d0f770bc6c`）。

数字核对：

| 项 | 值 |
|---|---|
| 模块行数合计 | 1642 = 参考文件 1642 |
| 模块字节合计 | 70942 |
| 模块间 CRLF 连接符 | 24（12 个 × 2 B） |
| 合计 | **70966 = 参考文件 70966 B** |

---

## 二、和仓库格式的对应关系

| 仓库模块 | 本切分 | 说明 |
|---|---|---|
| `dfInd_m1_util.il` | `ref_m2_util` | 仓库有 13 个几何原语；参考文件只有 1 个 `SnapToMinSpacing` |
| `dfInd_m2_config.il` | **无** | 参考文件没有配置表，常量直接写在各处 |
| `dfInd_m3_winding.il` | `ref_m6/m7/m8/m9/m10` | 仓库用 1 个文件 + `k` 循环；参考文件三段 case 各占一个模块 |
| `dfInd_m4_route.il` | `ref_m11_route` | 对应 |
| `dfInd_m5_pin.il` | `ref_m12_pin` | 对应（参考文件还含 Horizontal 重建） |
| `dfInd_m6_engine.il` | `ref_m5_engine` | 对应（参考文件的 engine 是 `case` 派发） |
| `dfInd_m7_cdf.il` | `ref_m1/m3/m4` | 仓库把 4 个兼容入口集中在 m7；参考文件分散在 3 处 |

**两处结构性差异**（不是切分问题，是代码本身不同）：

1. **参考文件没有 config 表**。仓库把 25.0/68.0/75.0/88.0/2.5/150.0 收进 `dfIndCfgTr7()`，
   参考文件把它们直接写在每个坐标表达式里。
2. **参考文件的三段 case 不能合并**。仓库用 `k` 单循环 + `tailMode` 参数；
   参考文件用 `a`/`b` 双层展开，每段独立写一遍。

---

## 三、这些模块能不能单独 load

**大部分不能。** 实测括号净深度：

| 模块 | 净深度 | 能否独立 load |
|---|---|---|
| `ref_m1` / `m2` / `m3` / `m4` | 0 | **可以**（各自是完整 procedure） |
| `ref_m5_engine` | **+6** | 不行，`let` 和 `case` 都未闭合 |
| `ref_m6` / `m7` / `m8` / `m9` | 0 | 括号平衡，但**变量未定义**，实际不能跑 |
| `ref_m10_case3` | **−1** | 不行，含 `);case` 闭合了 m5 打开的 `case` |
| `ref_m11_route` / `m12_pin` | 0 | 括号平衡，但位于 m5 的 `let` 内，变量依赖 m5 |
| `ref_m13_tail` | **−5** | 不行，负责闭合 m5 打开的 5 层 |

**结论**：`ref_m1`~`ref_m4` 是真正独立可 load 的 4 个 procedure。
其余 9 个模块是**阅读和提问用的切块**，拼回去才能运行。

这点必须说清楚，否则容易误以为可以逐个 `load` 调试。

---

## 四、怎么用

### 用途 1：按模块提问（对应 SOP 的 10 轮方案）

`ref_m5`~`ref_m13` 正好对应 SOP 的切块表，但粒度更细：

| SOP 轮次 | 对应模块 |
|---|---|
| R1 | `ref_m1` + `ref_m2` + `ref_m3` |
| R2 | `ref_m4` |
| R3 | `ref_m5` + `ref_m6` 前半 |
| R4–R5 | `ref_m6` 后半 |
| R6–R7 | `ref_m7` + `ref_m8` |
| R8–R9 | `ref_m9` + `ref_m10` |
| R10 | `ref_m11` + `ref_m12` + `ref_m13` |

### 用途 2：按模块比对产物

复现完成后，把产物按同样的行号边界切开，逐模块与参考模块 diff。
比整文件 diff 更容易定位是哪一块出的问题。

### 用途 3：喂给 AI 时控制上下文

`ref_m6_case7.il` 有 384 行 / 17.7 KB，是最大的一块。
如果某轮输出被截断，可以再按 `for(a 0 1` / `for(b 0 2` 拆成两半（L369、L455 是循环起点）。

---

## 五、文件清单

```
Result/ref_modular/
├── manifest.json          切分清单（行号、字节数、括号深度、sha256）
├── ref_m1_entry.il
├── ref_m2_util.il
├── ref_m3_cdf.il
├── ref_m4_callback.il
├── ref_m5_engine.il
├── ref_m6_case7.il
├── ref_m7_case6.il
├── ref_m8_case5.il
├── ref_m9_case4.il
├── ref_m10_case3.il
├── ref_m11_route.il
├── ref_m12_pin.il
├── ref_m13_tail.il
└── README.md              本文件
```

生成脚本：[`tools/deepseek_web/split_ref.py`](../../tools/deepseek_web/split_ref.py)

---

## 六、切分原则

1. **零字节改动**：纯按行号切，不重排、不改缩进、不补注释。
   验证方式是拼回去比 sha256。
2. **切在语句边界**：每个边界前一行都是完整语句（`);proc`、`);case`、`dbCreatePin(...)` 等）。
3. **按 `case` 分支切**：`((7)` 到 `);case---Tr=7` 是一个完整模块，读起来是一个整体。
4. **保留原始 CRLF**：不转 LF，避免和参考文件比对时出现全文件差异。
