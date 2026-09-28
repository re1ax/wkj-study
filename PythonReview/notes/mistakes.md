# 易错点记录

把复习中不熟、做错、容易混淆的点记录在这里。

## 模板

### 日期

- 问题：
- 错因：
- 正确理解：
- 相关例子：


- 问题：list[]在后面追加元素函数不熟悉
- 错因：函数不熟悉
- 正确理解：list.append(element)
- 相关例子：list.append(element)

- 问题：string分割函数
- 错因：函数不熟悉
- 正确理解：string.split()
- 相关例子："I love Python".split()

- 问题：range() 参数数量写错
- 错因：把倒序循环的参数写成了 4 个
- 正确理解：range() 最多接收 3 个参数：start, stop, step
- 相关例子：range(len(words) - 1, -1, -1)

- 问题：列表下标越界
- 错因：使用了错误的长度，例如用 len(word) 去访问 words
- 正确理解：访问列表时，最大合法下标是 len(list) - 1
- 相关例子：words[len(words) - 1]

- 问题：return 缩进位置错误
- 错因：return 写在 for 循环内部，导致函数提前结束
- 正确理解：如果要处理完整个列表，return 通常放在 for 循环外
- 相关例子：
```python
for item in items:
    ...
return result
```

- 问题：去重时没有记录已出现元素
- 错因：只判断 item not in seen，但没有执行 seen[item] = True
- 正确理解：判断之后要更新记录
- 相关例子：
```python
if item not in seen:
    result.append(item)
    seen[item] = True
```

- 问题：字符串比较使用 is
- 错因：混淆了对象身份比较和内容比较
- 正确理解：比较内容用 ==，判断是否同一个对象才用 is
- 相关例子：ch == " "

- 问题：字典计数时覆盖了原值
- 错因：遇到已有 key 时直接赋值，没有累加
- 正确理解：已有 key 应该在原值基础上增加
- 相关例子：
```python
if key in counts:
    counts[key] += value
else:
    counts[key] = value
```

- 问题：字符串是不可变对象
- 错因：以为修改循环变量 ch 会改变原字符串
- 正确理解：需要构造新的字符串或列表，再返回结果
- 相关例子：
```python
result = ""
for ch in text:
    result += ch
```
