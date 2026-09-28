# 练习总结

这个文件用于记录每一次练习后的复盘：题目考点、暴露的问题、推荐写法。

## Python 基础练习 01

文件：`exercises/python_basics_01.py`

### 主要考点

- 使用循环统计满足条件的元素数量。
- 手动拆分字符串，并按单词倒序拼接。
- 使用字典统计元素出现次数。
- 从字典列表中按条件筛选字段。
- 使用双层循环展开二维列表。

### 关键收获

遍历列表时，可以用下标：

```python
for i in range(len(numbers)):
    print(numbers[i])
```

但 Python 更常见的写法是直接遍历元素：

```python
for number in numbers:
    print(number)
```

字符串按单词处理时，常用：

```python
words = sentence.split()
```

把单词列表重新拼成字符串时，常用：

```python
" ".join(words)
```

倒序遍历列表时，注意最后一个合法下标是 `len(words) - 1`：

```python
for i in range(len(words) - 1, -1, -1):
    print(words[i])
```

### 易错点

- `range()` 最多接收 3 个参数：`start, stop, step`。
- 列表下标从 `0` 开始，最后一个下标是 `len(list) - 1`。
- 不要把字符串长度和列表长度混用，例如 `len(word)` 与 `len(words)` 是不同含义。
- 题目要求返回“姓名”时，不要返回整个学生字典。

## Python 基础练习 02

文件：`exercises/python_basics_02.py`

### 主要考点

- 使用 `split()` 拆分句子。
- 按条件把数据分到不同列表中。
- 去重并保持原始顺序。
- 合并两个计数字典。
- 实现单词首字母大写。

### 修正过程中的关键点

`group_by_score_level` 中，`return` 不能放在 `for` 循环内部，否则只处理第一个学生就结束函数。

推荐结构：

```python
for student in students:
    ...

return result
```

`remove_duplicates` 中，判断一个元素没出现过之后，需要把它记录下来：

```python
seen[item] = True
```

否则下一次遇到同一个元素时，程序仍然不知道它已经出现过。

`merge_counts` 中，相同 key 的值应该累加，而不是覆盖：

```python
if key in dict_a:
    dict_a[key] += dict_b[key]
else:
    dict_a[key] = dict_b[key]
```

`title_case` 中，Python 字符串不能像 C/C++ 那样做字符减法：

```python
'A' - 'a'  # 错误
```

应该使用字符串方法：

```python
word[0].upper() + word[1:].lower()
```

最终练习二的样例输出已经通过：

```text
['learning', 'Python']
{'high': ['Alice', 'Cindy'], 'mid': ['Bob'], 'low': ['Tom']}
[3, 1, 2]
{'python': 5, 'java': 1, 'c++': 1}
Hello Python
```

### 易错点

- `return` 的缩进位置决定函数什么时候结束。
- 去重时不仅要判断是否出现过，还要记录已经出现过的元素。
- 字典合并计数时，同名 key 要累加。
- 判断字符串内容是否相等用 `==`，不要用 `is`。
- 变量名不要使用 `hash`，因为 `hash` 是 Python 内置函数名。

### 后续优化建议

`group_by_score_level` 里可以直接返回字典：

```python
return {
    "high": high,
    "mid": mid,
    "low": low,
}
```

`remove_duplicates` 中建议把变量名 `hash` 改成 `seen`，语义更清楚，也避免覆盖内置函数名。

## Python 基础练习 03

文件：`exercises/python_basics_03.py`

### 主要考点

- 函数参数与返回值。
- 处理嵌套列表和嵌套字典。
- 使用 `try / except` 处理可能失败的转换。
- 用字符串方法解析简单文本。
- 继续练习“返回值必须符合题目要求”。

### 练习目标

这一组会比前两组更接近实际小任务：不是只处理一个列表，而是要把多步逻辑组合起来。

重点关注：

- 什么时候返回 `None`，什么时候返回空列表或空字典。
- 字符串转数字时可能抛出 `ValueError`。
- 嵌套数据里要先找到正确层级，再取字段。

### 已通过输出

```text
123
None
90.0
0.0
{'name': 'Bob', 'score': 78, 'city': 'Beijing'}
None
{'Shanghai': [90, 85], 'Beijing': [78]}
{'name': 'Alice', 'city': 'Shanghai', 'score': '90'}
```

### 后续优化建议

`safe_to_int` 更推荐用 `try / except`，这样可以处理负数和带空格的字符串：

```python
try:
    return int(value)
except ValueError:
    return None
```

不要用内置函数或内置类型名当变量名，例如：

- `sum`
- `str`
- `hash`

可以改成：

- `total`
- `parts`
- `seen`

判断字典里是否存在 key 时，可以直接写：

```python
if city in result:
    ...
```

不需要写成：

```python
if city in result.keys():
    ...
```

## Python 基础练习 04

文件：`exercises/python_basics_04.py`

### 主要考点

- 清洗字符串数据。
- 使用集合 `set` 做交集、差集和去重。
- 按字典字段排序。
- 使用默认参数。
- 解析 CSV 风格文本，为 Pandas 学习做铺垫。

### 练习目标

这一组开始接近“数据处理”任务。后续学习 Pandas 时，经常会遇到类似逻辑：

- 去掉空白字符。
- 过滤无效数据。
- 按某一列排序。
- 从文本中解析结构化数据。
- 找出两组数据的共同项或差异项。

### 已通过输出

```text
['Alice', 'Bob', 'Cindy']
[2, 3]
['Cindy', 'Alice']
{'Shanghai': 2, 'Beijing': 1, 'Shenzhen': 1}
[{'name': 'Alice', 'city': 'Shanghai', 'score': '90'}, {'name': 'Bob', 'city': 'Beijing', 'score': '78'}]
```

### 后续优化建议

- 清理字符串前后空白使用 `strip()`。
- 集合交集可以写成 `set_a & set_b`。
- 降序排序需要给 `sorted()` 传入 `reverse=True`。
- 使用切片 `items[:limit]` 时，`limit` 超过列表长度也不会报错。
- 解析文本前应考虑空字符串，避免访问 `lines[0]` 时发生 `IndexError`。

## Python 基础练习 05

文件：`exercises/python_basics_05.py`

### 主要考点

- 使用 `pathlib.Path` 处理文件路径。
- 使用 `with` 安全地打开和关闭文件。
- 读取普通文本和 JSON 数据。
- 捕获 `FileNotFoundError` 与 `json.JSONDecodeError`。
- 汇总数据并把结果保存为 JSON。

### 练习目标

完成一条简单的数据处理流程：

1. 从文件读取数据。
2. 把 JSON 转换为 Python 对象。
3. 计算人数、平均分和最高分学生。
4. 把汇总结果写入新文件。

这组练习完成后，就具备了使用 Python 处理本地数据文件的基础。

### 已通过输出

```text
['variables', 'lists', 'dictionaries', 'exceptions', 'file handling']
[{'name': 'Alice', 'score': 90, 'city': 'Shanghai'}, {'name': 'Bob', 'score': 78, 'city': 'Beijing'}, {'name': 'Cindy', 'score': 95, 'city': 'Shanghai'}, {'name': 'Tom', 'score': 60, 'city': 'Shenzhen'}]
{'count': 4, 'average': 80.75, 'top_student': 'Cindy', 'top_score': 95}
True
['score_summary_output.json', 'students.json']
```

### 关键收获

`json.load()` 需要传入文件对象，不是路径，也不是函数名：

```python
with open(file_path, "r", encoding="utf-8") as file:
    data = json.load(file)
```

`json.dump()` 用于把 Python 对象保存成 JSON：

```python
with open(file_path, "w", encoding="utf-8") as file:
    json.dump(data, file, ensure_ascii=False, indent=2)
```

使用 `Path` 可以更清晰地处理路径：

```python
path = Path(file_path)
path.parent.mkdir(parents=True, exist_ok=True)
```

### 后续优化建议

- 变量名 `sum_score` 可以改成 `total_score`。
- 打开文件时建议始终写明 `encoding="utf-8"`。
- 文件不存在、JSON 格式错误、空列表都应该返回题目要求的默认值。

## Python 基础练习 06

文件：`exercises/python_basics_06.py`

### 主要考点

- 定义类与创建对象。
- `__init__` 初始化实例属性。
- 实例方法与 `self`。
- 在类中维护列表数据。
- 用方法封装增删查改和统计逻辑。

### 练习目标

这一组开始复习面向对象。你要实现一个简单的成绩册类：

- 添加学生。
- 查找学生。
- 更新成绩。
- 计算平均分。
- 返回排名。

重点是理解：函数放进类之后，第一个参数通常是 `self`，它代表当前对象本身。

### 已通过输出

```text
True
True
True
False
{'name': 'Bob', 'score': 78}
None
True
False
89.0
['Cindy', 'Alice']
True
False
['Cindy', 'Bob']
```

### 关键收获

类里的实例属性要通过 `self` 保存：

```python
self.students = []
```

实例方法之间可以互相复用，例如 `add_student()` 可以调用 `find_student()` 判断学生是否存在。

排序后取前 `limit` 个元素时，切片应该写成：

```python
sorted_students[:limit]
```

不要写成：

```python
sorted_students[0:1 + limit]
```

题目要求返回姓名列表时，要从学生字典中取出 `"name"` 字段：

```python
result.append(student["name"])
```

### 后续优化建议

- 变量名不要使用 `sum`，可以用 `total` 或 `total_score`。
- `average_score()` 中 `total = 0.0` 比 `total : float = 0` 更自然。
- 删除列表元素时，当前写法可用；后续也可以学习用下标或列表推导式生成新列表。

## Python 基础练习 07

文件：`exercises/python_basics_07.py`

### 主要考点

- 列表推导式。
- 字典推导式。
- `lambda` 与 `sorted()`。
- 生成器函数与 `yield`。
- `enumerate()` 和 `zip()`。

### 练习目标

这一组开始练更 Pythonic 的数据处理写法。重点不是炫技，而是理解：

- 什么时候普通 `for` 循环更清晰。
- 什么时候推导式更简洁。
- 生成器为什么可以“一个一个地产生值”。
- `enumerate()` 用来同时拿到下标和值。
- `zip()` 用来把两组数据按位置配对。

### 已通过输出

```text
[4, 16, 36]
{'Alice': 90, 'Bob': 78, 'Cindy': 95}
['fig', 'kiwi', 'pear', 'apple', 'banana']
[1, 3, 6, 10]
[(0, 'a'), (1, 'b'), (2, 'c')]
[{'name': 'Alice', 'score': 90}, {'name': 'Bob', 'score': 78}]
```

### 关键收获

列表推导式适合“遍历 + 筛选 + 转换”：

```python
[number ** 2 for number in numbers if number % 2 == 0]
```

字典推导式适合从一组记录构造映射：

```python
{student["name"]: student["score"] for student in students}
```

`sorted()` 可以用元组作为排序 key，实现多条件排序：

```python
sorted(words, key=lambda word: (len(word), word))
```

生成器函数用 `yield` 逐个产出结果：

```python
def running_total(numbers):
    total = 0
    for number in numbers:
        total += number
        yield total
```

### 后续优化建议

- 条件表达式不需要额外括号：`if number % 2 == 0`。
- 字典冒号后加空格：`key: value`。
- 推导式很好用，但逻辑超过一行时，普通 `for` 循环常常更清楚。

## Python 基础练习 08

文件：`exercises/python_basics_08.py`

### 主要考点

- 高阶函数：函数作为参数。
- 闭包：函数返回函数。
- `*args` 和 `**kwargs`。
- 简单装饰器。
- 使用 `functools.wraps` 保留函数元信息。

### 练习目标

这一组会帮助你理解“函数也是对象”。这是后面学习装饰器、框架回调、数据处理管道时非常重要的基础。

重点关注：

- 可以把函数传给另一个函数。
- 内层函数可以记住外层函数的变量。
- `*args` 接收任意位置参数。
- `**kwargs` 接收任意关键字参数。
- 装饰器本质上是“接收函数，返回新函数”的函数。
