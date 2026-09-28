# CE-planner 投稿副本精简与验证日志

本文件记录投稿工作副本中的恢复、删除和回归。原始输入
`CE-planner-superB-8.zip` 的 SHA-256 为
`BA12E4431474903D051F69E5F3F6B85FEFB7E5196765015CCB58CAD938F12854`，
原始 ZIP 和只读审计解压目录均未修改。

## 阶段 0：恢复源码可构建性

### 恢复内容

B8 的 `lama/search/Makefile` 引用了 19 个不存在的 `.cc/.h` 文件，
`cegis_framework.cc` 又包含一个不存在的
`cegis_native_runtime.inc`。从 `CE-planner-superB-6.zip` 只恢复这 20
个源码文件，共 1,461,089 B：

```text
axioms.cc
axioms.h
best_first_search.cc
best_first_search.h
cadical_counter.cc
cadical_counter.h
cegis_framework.cc
cegis_framework.h
cegis_native_runtime.inc
closed_list.cc
closed_list.h
cnf_builder.cc
cnf_builder.h
cnf_logger.cc
cnf_logger.h
cnf_preprocessor.cc
cnf_preprocessor.h
cnf_types.cc
cnf_types.h
counter_cnf.cc
```

恢复依据：

- B8 原始包执行 `make -n release-search` 在
  `best_first_search.cc` 处必然失败。
- B6 与 B8 的 51 个同名 search/顶层关键文件逐字节相同。
- B6 的 CEGIS 源码 SHA-256 为
  `8975A6CEFC3C6286406134AD52A2F9CA41F3E9E1688A567B3E9975E8A975A048`，
  含 B8 现有二进制中的 V16 特征标记。
- 未恢复 B6 中的对象文件、旧二进制、备份源码或运行结果。

### 构建结果

- 环境：Ubuntu 20.04 WSL，GCC/G++、Z3、Kissat 静态库。
- 命令：`make release-search -j2`
- 结果：成功。
- 新二进制：`lama/search/release-search`
- 大小：2,990,536 B
- SHA-256：
  `094BE100812880C85B030598592A2F4C9600EA955938AAADABCCD13834FCB0EA`
- `ldd`：所有依赖均解析，最低环境不再被 B8 预编译文件的 glibc
  2.38 要求阻塞。

编译有既有警告，但无缺文件或链接错误。特别记录：
`counter.cc::planType()` 是非 `void` 函数但缺少返回值；为避免在精简任务中
擅自改变算法行为，本阶段不修改。

### 动态基线：T1 / blocks/b3

- 命令：
  `IGC_FALLBACK_PROFILE=quick-debug ./run-test-ce.sh --solver t1 --case blocks/b3 --timeout 180`
- 结果：47 秒，`final_status=VALID`，输出 37 步计划。
- 动态跟踪确认调用：
  Python 2 translator → LAMA preprocess → 新编译的 release-search →
  `T1/t1` → `T1/libdnnf/c2d_linux`。
- 第 0 轮 refined 生成 PDDL 和候选计划，验证器发现新反例。
- 第 1 轮 refined 生成含两个世界的 PDDL；T1 在 30 秒门限超时，
  进程树被完整清理。
- 第 2 轮读取
  `test/.native-fallback/T1-Benchmark-succes/blocks/{domain.pddl,b3.pddl}`
  的字节相同副本，T1 返回候选计划。
- 最终 CNF/Kissat 验证结果为 `VALID`。

### 已知基线缺陷

`IGC_CEGIS_SELFTEST=1` 在 B8 原二进制和上述重建二进制上均返回
`final_status=BACKEND_ERROR`。它是输入基线已有问题，不能标为通过；真实
T1 端到端用例仍成功。

## 阶段 1：低风险元数据、缓存和运行产物

计划删除并在删除后重建/回归：

| 集合 | 证据 | 处理 |
|---|---|---|
| 根 `.git`、`iGC/.git`、`third_party/kissat/.git` | 构建/运行无读取；合计约 105.91 MiB | 删除 |
| 根及 iGC `.vscode` | 编辑器配置，含开发机绝对路径 | 删除 |
| iCPCES 以外的 `.o/.release.o/.profile.o` | 可重建；核心运行只读取最终二进制/静态库 | 删除后全编译 |
| `__pycache__`, `.pyc`, `.pyo` | Python 自动生成 | 删除 |
| 顶层 `output*`, `C_Plan`, `finalplan`, `belief`, `all.groups`, `test.groups`, `oneof*`, `examples.1`, `result*`, `trans_file` | 均为实际运行生成的 SAS/计划/日志中间结果 | 删除 |
| `planner_run.log`, `system-test-env-report.log`, T0 历史日志 | 运行日志；环境报告含个人机器信息 | 删除 |
| `new.pl~`, `*.bak`, `#OLD-*#` | 正式文件存在且构建/运行脚本不引用备份名 | 删除 |
| 本轮 `runs`, `test_logs_ce`, `result_output_batch_ce` | 动态证据已复制到审计目录；运行可重建 | 从投稿副本删除 |

门禁：

1. 从没有 search 对象文件的状态重新编译；
2. 运行 `plan-cegis --help`；
3. 重跑 T1 / blocks/b3；
4. 比较最终状态、计划验证和实际候选规划器调用。

### 阶段 1 实际结果

- 采用可回滚隔离而非不可恢复删除：
  `<external-audit-root>/quarantine-stage1`
- 移出 Git 元数据：约 105.91 MiB。
- 移出 editor、运行目录和上一轮对象：约 4.52 MiB。
- 移出其余对象、Python 缓存、日志、备份和顶层生成结果：
  413 个文件，约 4.00 MiB。
- 合计约 114.4 MiB；iCPCES 的 `downward/builds` 尚未处理。
- 从无 preprocess/search 对象文件的状态重新编译：成功。
- T1 / blocks/b3 重跑：45 秒，`final_status=VALID`。
- 行为与阶段 0 一致：refined 生成、反例回流、T1 超时清理、native
  fallback、最终 CNF/Kissat 验证均执行。

结论：阶段 1 清理通过门禁。

## 阶段 2：iCPCES 本机 Fast Downward 构建树

处理前规则：

1. 不删除 `iCPCES/downward` 的源码、driver、构建配置或许可证。
2. 先强制验证代码已支持的 Linux FF 后端。
3. 仅在 FF 路线能生成/读取候选计划并通过最终验证后，隔离
   `iCPCES/downward/builds`。
4. 隔离后重复同一用例，排除代码暗中依赖构建树的可能。

### 阶段 2 依赖修复

iCPCES/FF 首次运行揭示两项原包已有缺陷：

1. Ubuntu 20.04 缺少 Python Z3 绑定。未固定版本的
   `pip install z3-solver` 在 2026-07 拉取 5.0 源码并要求 C++20，
   与 GCC 9 不兼容；固定 `z3-solver==4.12.2.0` 后安装成功。
2. `Z3_object_constraints.py` 读取概率规划字段
   `initial_probability_groups`，但本项目非概率 `Task` 和并行的
   `Z3_string_constraints.py` 均使用 `unknown_init_group`。已改为正确字段。
3. 对象约束的 `extract_counter_example()` 返回 `Atom`，而所有下游
   sample PDDL writer 及现存 `predicates_map` 接口要求格式化字符串。
   已在提取边界使用 `get_formated_expression()`，保持后续接口一致。

这些修复均由实际 traceback、类型定义和同功能实现交叉验证，不是为通过
测试而跳过约束。

### 阶段 2 实际结果

- 修复后 iCPCES/FF `blocks/b3` 完整运行：`final_status=VALID`。
- 快速门禁（移动前）：
  iCPCES/FF `blocks/b2`、direct profile，10 秒，`VALID`。
- 隔离：
  `iCPCES/downward/builds`，553 个文件，509.19 MiB。
- 隔离位置：
  `<external-audit-root>/quarantine-stage2/icpces-downward-builds`
- 快速门禁（移动后）：同一命令 9 秒，`VALID`。
- `iCPCES/downward` 源码、driver、build config 和许可证仍保留。
- 无本机构建树时，候选 runner 自动选择并安装 gCPCES 提供的 Linux
  `ff`，不再尝试归档中要求 glibc 2.38 的开发机 Fast Downward 二进制。

结论：阶段 2 清理通过门禁。

已知问题：一次 `blocks/b3 --timeout 240` 成功运行在批量脚本中记录为
385 秒，说明外层计时/超时统计可能受 WSL 或内部会话等待影响；不据此声称
240 秒门限严格生效。

## 阶段 3：测试集白名单

在删除任何 benchmark 前，逐个核对：

- 公共 domain/problem 是否存在；
- 12 个 `.native-fallback` 库是否存在相同小型用例；
- CPAH 是否需要 AL 而非 PDDL 对；
- 用例是否覆盖 refined、多轮反例、native fallback 和不同初始公式；
- 白名单总大小和可运行时长。

### 白名单

公共快速测试：

| 域 | 目的 |
|---|---|
| `blocks`（只保留 `domain.pddl`, `b2.pddl`, `b3.pddl`） | b2 快速成功；b3 已验证多轮 refined、反例和 fallback |
| `bomb` | CPAH/CPA 路线和不确定初始状态 |
| `or-coins` | 显式 OR 初始公式 |
| `adder-IPC5` | IPC 风格结构化不确定性 |
| `omlette` | T1/CFF 的小型代表域 |
| `safe` | 小型安全/感知代表域 |

原生回退库按线路只保留能支持上述快速验证的域：

| 原生库 | 保留域 |
|---|---|
| CFF | `blocks`, `omlette` |
| CNF（嵌套 success 目录） | `blocks`, `or-coins` |
| CPA/CpAH | `blocks`, `bomb` |
| DNF | `blocks`, `or-coins` |
| GC-LAMA | `blocks`, `safe` |
| gCPCES | `blocks`, `safe` |
| iCPCES | `blocks`, `safe` |
| iGC | `blocks`, `safe` |
| PIP | `blocks`, `or-coins` |
| POND | `blocks`, `safe` |
| T0 | `blocks`, `bomb` |
| T1 | `blocks`, `omlette` |

## 阶段 4：候选规划器兼容修复、去重与二进制瘦身

- T0：修复带空格路径的参数引用；通过相对运行期符号链接满足旧工具的固定目录假设。`blocks/b2` 通过。
- gCPCES：从 Java 源码以 `javac --release 11` 重编译；候选 FF/MpC 和 PDDL 输入在隔离工作区暂存。`blocks/b2` 通过。
- CFF：从输入仓库自身的历史对象恢复 34 个 C 源码/头文件/构建文件，替换要求较新 glibc 的旧二进制并在 Ubuntu 20.04 重编译。`blocks/b2` 通过。
- iGC：从其嵌套仓库恢复 41 个搜索源码/头文件/构建文件；将旧 Z3 `parse_string()` 单表达式调用适配为表达式向量逐项加入；使用该源码支持的 `fF` 参数。`blocks/b2` 通过。
- 经静态 workspace 代码和动态运行确认，隔离 GC-LAMA/iGC 的两个调试 `search` 及两个重复 `verify` 后，两条线路继续通过。
- 隔离 gCPCES `src` 下重复 FF/MpC 和陈旧 class 后，gCPCES 继续通过。
- 36 个保留 ELF 均先复制到外部审计隔离区，再执行 `strip --strip-unneeded`：86.715 MiB 降至 20.512 MiB，释放 66.203 MiB。
- 去符号后 T0、T1、CFF、POND、iGC、GC-LAMA、gCPCES、iCPCES 八条开放依赖线路全部 `VALID`。
- CNF、DNF、PIP、CpAH 的真实入口均运行至 SICStus 调用；因审计环境无合法商业安装，明确记录为 external dependency blocked，而非测试通过。

## 阶段 5：投稿复现层与干净构建

- 新增 `setup.sh`、`build.sh`、`check-installation.sh`、`run-example.sh`、`run-all-examples.sh` 和固定版本 `requirements.txt`。
- 从无 Kissat build、无核心对象、无 CFF 对象、无 gCPCES class 的状态运行 `./build.sh --clean`：Kissat、核心 preprocess/search、CFF、iGC、GC-LAMA preprocess 和 gCPCES Java 全部成功重建。
- 安装检查结果：`failures=0 warnings=1`；唯一警告是未安装 SICStus。
- 干净构建后八条开放依赖路线 `blocks/b2` 矩阵再次全部 `VALID`。
- 最终清理再次隔离 1,173 个可重建/运行生成文件，共 15.962 MiB；保留最终二进制、gCPCES class、源码和脚本。
- 最终工作树预审计为 1,691 个文件、56.198 MiB 未压缩；预览 ZIP 为 32.524 MiB，低于 50 MB 门限。
- 已清除源码/脚本中的开发机绝对路径；`build.txt` 及其中的私有 SICStus 许可证值未进入投稿树。

保留整个列出的原生域目录，不进一步猜测删除其中的 planner-specific
样例、sample plan 或预转换文件。完整 benchmark 不进入投稿包；README
说明应从补充材料/项目方提供的外部地址恢复到相同目录结构。

## 阶段 6：正式归档前内容卫生复核

- 发现 `CpAH/run_cpah.sh.orig.20260601_185826`（255 字节）为历史备份。
- 全仓库静态搜索没有任何构建脚本、运行脚本、源码或文档引用该名称；正式入口为同目录下的 `run_cpah.sh`。
- 单独删除该备份后重新执行构建、安装检查和路线回归，不与其他高风险清理合并。
- 删除后构建成功，安装检查为 `failures=0 warnings=1`，八条开放依赖线路回归为 8/8 `VALID`。
- 最终归档含 1,689 个文件条目，未压缩文件内容约 56.206 MiB，ZIP 为 32.527 MiB。

## 阶段 7：Ubuntu 24.04 兼容性回归

- 实际复现 Ubuntu 24 的 PEP 668 拒绝旧版系统/用户级 pip 安装方式。
- 改用项目私有 Python 3 虚拟环境，并固定
  `setuptools==69.5.1` 和 `z3-solver==4.12.2.0`。
- 使用 GCC 13 从官方源码成功构建项目私有 Python 2.7.18。
- 主路线入口同时解析两个项目私有 Python 环境；直接运行路线不再依赖
  便捷测试脚本预先修改 `PATH`。
- GCC 13/OpenJDK 21 全量干净构建通过。
- 安装检查为 `failures=0 warnings=1`，唯一警告是预期的商业
  SICStus 缺失。
- `blocks/b2` 的八条开放依赖路线全部 `VALID`。
- 单独调用 CNF、DNF、PIP 和 CpAH；四条线路均完成 Python 2
  前端并到达 `sicstus: not found`，确认剩余阻塞是已记录的外部许可依赖。
- 归档绝对路径复核发现 T0 translator 目录中的 9 个
  `result_translator-t0_*` 历史 `.stat/.time/.ipc5` 运行结果；精确文件名
  静态引用数均为 0，且当前 T0 框架会在每轮隔离目录中先清除并重新生成
  同名结果。将这 9 个文件移至外部隔离区，并把上游 README 的开发者
  绝对路径示例改为基于当前目录的写法。
- Ubuntu 24 重发版包含 1,681 个文件条目，未压缩文件内容
  58,942,683 字节（56.212 MiB），ZIP 约 32.46 MiB。
