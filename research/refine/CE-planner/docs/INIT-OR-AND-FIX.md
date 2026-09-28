# `:init` 中 `or` 嵌套 `and`：方案 A 修复说明

## 1. 本次采用的方案

修复 CE-planner 的公共翻译入口，使以下初始约束能够保留为“多个合取项的析取”，交给项目已有的 CNF 编码器处理：

```lisp
(:init
  (or
    (and (a) (not (b)))
    (and (c) (d))))
```

对应公式为：

```text
F = (a ∧ ¬b) ∨ (c ∧ d)
```

方案 A 保留原 PDDL 的 OR 分组及各备选项顺序，在公共前端修复原子收集、变量保留和约束序列化。后续复用现有 AND 门生成 CNF，不在 PDDL 层做笛卡尔积展开。

这次修改影响项目统一入口的调用链：

```text
plan-cegis-<候选规划器>
  → plan-cegis
  → plan
  → lama/translate/translate.py
  → lama/preprocess/preprocess
  → lama/search/release-search
  → CEGIS / InitialConstraintIR / CounterCNF / 候选规划器适配器
```

各候选规划器目录内的独立入口不经过这条公共翻译链时，不会自动获得本次修复。各后端自身的语法能力和运行依赖仍适用。

## 2. 修复前为什么失败

### 2.1 公式节点被当作初始原子

`lama/translate/pddl/conditions.py` 已经能够解析 `or` 和 `and`。

问题出在 `pddl/tasks.py`：旧代码在只有 OR、没有 ONEOF 的情况下，把 OR 的直接子节点加入 `task.init`：

```python
for k in range(0, len(orclause.parts)):
    initial.append(orclause.parts[k])
```

对于本例，加入的是两个 `Conjunction` 节点。随后 `pddl_to_prolog.py::translate_facts` 要求其中只能是 `Atom` 或数值赋值 `Assign`：

```python
assert isinstance(fact, pddl.Atom) or isinstance(fact, pddl.Assign)
```

因此从源码可定位到的失败路径是：**解析成功 → 合取节点进入原子列表 → Datalog 转换断言失败**，尚未进入 CNF 编码阶段。

### 2.2 仅修改这个断言还不够

- OR 与 ONEOF 同时出现时，旧分支没有把 OR 中的可能原子补入初始探索集合，可能漏掉实例化所需的事实。
- `instantiate.py` 原来没有专门保护 OR 中的不确定原子。没有动作修改的原子可能被当作静态真值处理，导致约束被提前消除。
- `write_oneof_file` 通过 `print_atom()` 的文本子串匹配寻找 SAS 变量。合取项中的负文字不能可靠地通过“先否定整个项，再匹配字符串”恢复，存在漏写或符号错误的风险。
- 公共预处理器还会按目标相关性删除 SAS 变量；原始初始约束可能继续引用这些变量，导致 `InitialConstraintIR` 无法映射。

## 3. 修改文件与内容

| 文件 | 修改内容 |
| --- | --- |
| `lama/translate/pddl/initial_constraints.py`（新增） | 校验 OR 形式；递归提取合取项内的文字；收集去重后的正原子；根据完整原子名称查找 SAS 映射；按已有格式序列化 OR/ONEOF。 |
| `lama/translate/pddl/tasks.py` | 含 OR 时，把可能出现的原子加入 `task.init`，公式树继续保存在 `task.ors` / `task.oneofs`；同时处理两种分组共存的情况。 |
| `lama/translate/instantiate.py` | 含 OR 时，将所有不确定文字对应的原子保留为 fluent facts，包括只以负文字出现、没有动作修改的原子。 |
| `lama/translate/translate.py` | 含 OR 时使用新序列化函数，同时写出 `oneof` 和 `oneof_initial`；在打开这些文件前检查全部文字的 SAS 映射。 |
| `plan` | 当 `oneof_initial` 的首行为 `OR` 时，给公共预处理器传入额外参数，启用它已有的保留变量功能。 |

示例文件：

- `examples/init-or-and/domain.pddl`
- `examples/init-or-and/problem.pddl`

### 3.1 原子收集与逻辑约束分开保存

本例的探索集合加入 `a、b、c、d`，其中 `b` 是负文字 `¬b` 对应的正原子。这是为了让实例化和 SAS 映射知道该原子的存在。

**这不表示初始世界中四个原子都必须为真。** 真正的信念约束仍是 `(a ∧ ¬b) ∨ (c ∧ d)`。`CounterCNF::compute_unknown_fact_mask` 会将分组涉及的变量标记为不确定变量，避免把探索种子的值直接作为确定事实写入 CNF。

### 3.2 保留项边界与符号

假设翻译后 `a、b、c、d` 分别对应 `var0、var1、var2、var3` 的值 `0`，新序列化结果为：

```text
OR
1
var0
0
var1
-1
,
var2
0
var3
0
,
END_OR
ONEOF
0
```

说明：

- 第一个逗号结束整个合取项 `a ∧ ¬b`，第二个逗号结束 `c ∧ d`。
- 正文字编码为值 `v`；负文字编码为 `-(v + 1)`。所以值 `0` 的否定编码为 `-1`。
- 实际变量编号由翻译器分配，不能假定始终与上述示意一致。
- OR 组与 ONEOF 组仍分别按各自在原 PDDL 中的顺序输出；每组内部的备选项顺序保持不变。

CEGIS 的部分 PDDL 生成逻辑会按组和备选项的位置对应原始 PDDL 与 `InitialConstraintIR`。因此本次没有将一个 OR 组拆成多个组，也没有把一个合取项拆成多个备选项。

### 3.3 预处理衔接

`lama/preprocess/planner.cc` 已有逻辑：只要接收到额外命令行参数，就设置 `g_do_not_prune_variables = true`。

`plan` 现在只对含 OR 的任务调用：

```sh
"$PREPROCESS" --keep-initial-constraints < output.sas
```

参数名字用于说明意图；现有 C++ 实现检查的是参数数量。这样能保留初始约束引用的变量，不需要重新编译 C++。

代价是含 OR 的任务会保留更多 SAS 变量，可能增加预处理和搜索开销。

## 4. CNF 如何生成，和笛卡尔积有什么关系

现有 `CounterCNF` 按每个合取项调用 `CnfBuilder::make_and_gate`。对于本例，可用两个 SAT 辅助变量表示：

```text
t1 ↔ (a ∧ ¬b)
t2 ↔ (c ∧ d)
t1 ∨ t2
```

相应的布尔 CNF 为：

```text
(¬t1 ∨ a)
∧ (¬t1 ∨ ¬b)
∧ (t1 ∨ ¬a ∨ b)
∧ (¬t2 ∨ c)
∧ (¬t2 ∨ d)
∧ (t2 ∨ ¬c ∨ ¬d)
∧ (t1 ∨ t2)
```

这里省略了系统另外生成的 SAS 值域约束。辅助变量仅存在于 SAT 编码内部，不加入 PDDL 的谓词或动作。

严格关系是 `F(a,b,c,d) ≡ ∃t1,t2 CNF(a,b,c,d,t1,t2)`：投影回原始变量后，初始世界集合保持一致。

使用笛卡尔积分配也能得到等价 CNF：

```text
(a ∨ c) ∧ (a ∨ d) ∧ (¬b ∨ c) ∧ (¬b ∨ d)
```

本例只有四个子句，展开很小。但对 `k` 个合取项、每项 `m_i` 个文字，直接展开在化简前可能产生 `∏m_i` 个子句。方案 A 复用合取门，对这种 OR-of-AND 的编码规模随文字总数线性增长，并保留项目依赖的原始分组结构。

**OR 允许多个合取项同时成立。** 项之间的互斥子句只用于 ONEOF 组。

## 5. 示例：修复前后的差异

完整问题文件 `examples/init-or-and/problem.pddl`：

```lisp
(define (problem init-or-and-example)
  (:domain init-or-and)
  (:init
    (or
      (and (a) (not (b)))
      (and (c) (d))))
  (:goal (done)))
```

配套 domain 中只有动作 `finish`：当 `a ∧ ¬b` 成立时令 `done` 成立；当 `c ∧ d` 成立时也令 `done` 成立。两条规则都是条件效果。

| 环节 | 修复前 | 修复后按代码逻辑应有的行为 |
| --- | --- | --- |
| PDDL 解析 | 可以得到 OR/AND 树 | 保留同样的分组和备选项 |
| `task.init` | 含两个 `Conjunction` | 含实例化所需的原子 |
| Datalog 转换 | 触发原子类型断言 | 原子类型满足转换要求 |
| 初始约束 | 无法走到可靠的编码阶段 | 一个 OR 组、两个合取项，保留 `¬b` |
| CNF | 尚未进入 | 复用现有合取门编码 |
| 规划语义 | 无法处理该输入 | `(finish)` 在所有合法初始世界中实现目标 |

对四个布尔原子共有 16 种赋值，其中 7 种满足本例公式。部分赋值如下：

| a | b | c | d | 是否为合法初始世界 | 原因 |
| --- | --- | --- | --- | --- | --- |
| 1 | 0 | 0 | 0 | 是 | 第一项成立 |
| 0 | 1 | 1 | 1 | 是 | 第二项成立 |
| 1 | 0 | 1 | 1 | 是 | 两项同时成立，OR 允许 |
| 1 | 1 | 0 | 0 | 否 | 第一项的 `¬b` 不成立 |
| 0 | 0 | 1 | 0 | 否 | 两项均不成立 |

`done` 初始为假；每个合法初始世界至少满足一条条件效果，因此动作序列 `(finish)` 是语义上预期的解，空计划不是解。这里是逻辑推导，不是本次运行得到的规划结果。

## 6. 使用方式与核验状态

本次完成的是源码修改及调用链的静态检查，**未执行运行测试或十二条候选规划器线路的回归测试**。当前 Windows 环境没有可用的项目 Python 2/Linux 运行链；没有把生产代码迁移到 Python 3，也没有以 Python 3 兼容转换的结果代替原环境验证。

在已经按项目要求安装好 Python 2 和各组件的 Linux 环境中，可从项目根目录运行下面的示例。命令为后续复现步骤，本次没有执行：

```sh
./plan-cegis-cnf \
  examples/init-or-and/domain.pddl \
  examples/init-or-and/problem.pddl \
  /tmp/ce-init-or-and-result.txt false
```

也可以通过已安装的其他 `plan-cegis-<route>` 入口复现。候选规划器的运行结果还取决于对应后端的支持情况。

若只检查公共翻译器，可在临时目录中运行，避免覆盖项目根目录的翻译产物：

```sh
PROJECT_DIR="$PWD"
CHECK_DIR="$(mktemp -d)"
cd "$CHECK_DIR"
python2 "$PROJECT_DIR/lama/translate/translate.py" \
  "$PROJECT_DIR/examples/init-or-and/domain.pddl" \
  "$PROJECT_DIR/examples/init-or-and/problem.pddl"
```

建议后续运行核验关注：本例、纯正文字的 OR-of-AND、只有负文字的备选项、多个 OR 组、OR 与 ONEOF 混用，以及原有无 OR / 仅 ONEOF 的样例。核对输出时应通过 `test.groups` / `all.groups` 的实际映射解释变量编号，不应要求编号固定。

## 7. 兼容范围与回退

- 新的原子收集、变量保护和约束输出路径在 `task.ors` 非空时启用。
- 无 OR 时，原有 ONEOF 处理与序列化的计算分支继续保留；本次未对其做全量回归验证。
- 支持 OR 的备选项为正原子、负原子或非空的文字合取；合取内部继续嵌套同类 AND 时会递归展开为该项的文字列表。
- 本次不是任意初始逻辑公式的通用归一化器。OR 项内部再出现 OR、ONEOF、量词、复合否定、空 AND 等会明确报错；不要把 `(:init (and ...))` 顶层包装写法视为本次新增支持。
- 原项目对“同一事实既作为确定初始事实，又出现在不确定组中”等输入的整体语义问题不在本次修复范围内。
- 含 OR 任务的实例化候选集合和保留变量数可能增大；没有性能测试数据。

本次修改前的公共翻译器与 `plan` 已备份到：

```text
C:\Users\Melody\AppData\Local\Temp\ce-planner-init-or-and-20260925-151247\
  translate-before\
  plan-before
```

需要回退时，从备份恢复 `pddl/tasks.py`、`instantiate.py`、`translate.py` 和 `plan`，并移除新增的 `pddl/initial_constraints.py` 即可。若之后有其他修改，请按差异选择性恢复，避免覆盖后续工作。示例和本说明文档可以独立保留。临时目录可能被系统清理，长期保留备份时应另行保存。
