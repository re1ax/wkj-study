# LRU 开发复盘

这次 LRU 初版已经能通过基础测试，但开发过程中暴露出一些很有价值的问题。下面按主题总结，后续写 LFU、ARC 或重构 LRU 时可以对照检查。

## 1. 模板类使用不熟练

一开始使用模板类时，容易忘记带模板参数，例如：

```cpp
std::shared_ptr<ILruNode>
```

但 `ILruNode` 是模板类，实际使用时应该明确类型：

```cpp
std::shared_ptr<ILruNode<Key, Value>>
```

改进建议：

- 看到 `template <typename Key, typename Value>` 时，后续使用类名通常都要带 `<Key, Value>`。
- 模板代码只有在实例化时才会真正检查，所以要尽早在测试里创建具体对象。

## 2. shared_ptr 和 weak_ptr 理解还需要加强

这次主要问题集中在：

- 对 `shared_ptr` 使用 `delete`
- 试图给 `const shared_ptr` 重新赋值
- 把 `weak_ptr` 当成普通指针使用
- 对 `weak_ptr` 使用 `nullptr` 初始化

应该记住：

```text
shared_ptr 管理对象生命周期，不手动 delete。
weak_ptr 不拥有对象，访问前要 lock()。
reset() 是断开智能指针关系。
```

双向链表中使用：

```cpp
std::shared_ptr<Node> next;
std::weak_ptr<Node> prev;
```

可以避免 `next` 和 `prev` 互相持有导致循环引用。

## 3. 链表边界情况容易遗漏

`deleteNode` 需要分别考虑：

```text
空节点
只有一个节点
删除头节点
删除尾节点
删除中间节点
```

这类代码不能只凭直觉写，需要先画出链表状态变化：

```text
A <-> B <-> C
```

删除 `B` 时：

```text
A->next = C
C->prev = A
B->next = nullptr
B->prev.reset()
```

改进建议：

- 写链表操作前先画图。
- 每个分支都想清楚 head、tail、prev、next 是否仍然一致。
- 删除节点后尽量断开该节点原来的连接，避免残留关系影响后续移动。

## 4. 接口设计还可以更自然

当前接口使用：

```cpp
void put(Key& key, Value& value);
bool get(Key& key, Value& value);
Value get(Key& key);
```

更推荐后续改成：

```cpp
void put(const Key& key, const Value& value);
bool get(const Key& key, Value& value);
Value get(const Key& key);
```

原因：

- `put` 不应该修改传入的 key 和 value。
- `get` 不应该修改传入的 key。
- `const &` 可以避免不必要拷贝，也能接收临时值或常量。

## 5. 测试写得太晚

一开始只是 include 头文件，很多模板错误没有暴露出来。直到测试里真正写：

```cpp
ICache::ILruCache<int, std::string> cache(2);
```

编译器才开始检查模板内部逻辑。

改进建议：

- 每实现一个小功能，就写一个最小测试。
- 测试不仅验证运行结果，也能帮助模板代码尽早实例化。
- 基础 LRU 至少测试：
  - put 后能 get
  - key 不存在返回 false
  - 超容量淘汰最久未使用
  - get 后刷新最近使用状态
  - put 已存在 key 更新 value
  - capacity 为 0 时 put 不生效

## 6. 还需要补的边界处理

当前 LRU 初版通过了基础测试，但还应继续完善：

- `capacity <= 0` 时，`put` 应直接返回。
- 右值构造函数里的 `prev(nullptr)` 应改成默认构造。
- 中间节点删除时，可以用 `preNode` 赋给下一个节点的 `prev`，可读性更好。
- `deleteNode` 的头尾删除分支可以更彻底地断开旧节点连接。

## 7. 下一步建议

先不要急着写 LFU。建议先做一次 LRU 小重构：

1. 把 `ICachePolicy` 参数改成 `const Key&` / `const Value&`。
2. 补 `capacity = 0` 测试。
3. 清理 `deleteNode`，让每个分支都断开旧节点连接。
4. 再运行测试，确保行为不变。
5. 最后再开始 LFU。

这次最重要的收获不是写出了 LRU，而是理解了：模板、智能指针、链表边界、测试实例化，这些东西在真实代码里是连在一起的。
