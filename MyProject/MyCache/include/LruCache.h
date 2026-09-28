#pragma once
#include <cmath>
#include <memory>
#include <mutex>
#include <thread>
#include <unordered_map>
#include <vector>

#include "ICachePolicy.h"

namespace ICache {
// 前向声明
template <typename Key, typename Value>
struct ILruNode;
template <typename Key, typename Value>
class ILinkedList;
template <typename Key, typename Value>
class ILruCache;

template <typename Key, typename Value>
struct ILruNode {
    Key m_key;
    Value m_value;
    std::shared_ptr<ILruNode<Key, Value>> next;
    std::weak_ptr<ILruNode<Key, Value>> prev;

    // 接受右值的构造函数
    ILruNode(Key&& key, Value&& value)
        : m_key(std::move(key)),
          m_value(std::move(value)),
          next(nullptr),
          prev() {}

    // 接受左值的构造函数
    ILruNode(const Key& key, const Value& value)
        : m_key(key), m_value(value), next(nullptr), prev() {}
};

template <typename Key, typename Value>
class ILinkedList {
private:
    std::shared_ptr<ILruNode<Key, Value>> m_head;
    std::shared_ptr<ILruNode<Key, Value>> m_tail;

public:
    ILinkedList() {
        m_head = nullptr;
        m_tail = nullptr;
    }
    void addNewNode(const std::shared_ptr<ILruNode<Key, Value>> node) {
        if (m_head == nullptr) {
            m_head = node;
            m_tail = node;
            return;
        }
        node->next = m_head;
        m_head->prev = node;
        m_head = node;
    }

    void deleteNode(const std::shared_ptr<ILruNode<Key, Value>> node) {
        if (node == nullptr) return;
        if (node == m_head && node == m_tail) {
            m_head = nullptr;
            m_tail = nullptr;
            return;
        }
        if (node == m_head) {
            m_head = m_head->next;
            node->next = nullptr;
            m_head->prev.reset();
            return;
        }
        if (node == m_tail) {
            m_tail = m_tail->prev.lock();
            m_tail->next = nullptr;
            node->prev.reset();
            return;
        }
        auto preNode = node->prev.lock();
        preNode->next = node->next;
        node->next->prev = node->prev;
        node->next = nullptr;
        node->prev.reset();
    }

    void addOldNode(const std::shared_ptr<ILruNode<Key, Value>> node) {
        if (node == m_head) {
            return;
        }
        deleteNode(node);
        addNewNode(node);
    }
    void deleteTailNode() { deleteNode(m_tail); }

    std::shared_ptr<ILruNode<Key, Value>> getTailNode() { return m_tail; }
};

template <typename Key, typename Value>
class ILruCache : public ICachePolicy<Key, Value> {
private:
    int m_capacity;
    int m_size;
    ILinkedList<Key, Value> m_iLinkedList;
    std::unordered_map<Key, std::shared_ptr<ILruNode<Key, Value>>> m_hashMap;
    std::mutex m_mutex;

public:
    ILruCache(int capacity) : m_capacity(capacity), m_size(0) {}
    // 添加缓存
    void put(const Key& key, const Value& value) override {
        std::lock_guard<std::mutex> lock(m_mutex);
        if (m_capacity <= 0) return;
        if (m_hashMap.find(key) == m_hashMap.end()) {
            if (m_size >= m_capacity) {
                m_hashMap.erase(m_iLinkedList.getTailNode()->m_key);
                m_iLinkedList.deleteTailNode();
                m_size--;
            }
            m_size++;
            auto newNode = std::make_shared<ILruNode<Key, Value>>(key, value);
            m_iLinkedList.addNewNode(newNode);
            m_hashMap[key] = newNode;
        } else {
            m_hashMap[key]->m_value = value;
            m_iLinkedList.addOldNode(m_hashMap[key]);
        }
    }

    // key是传入参数  访问到的值以传出参数的形式返回 | 访问成功返回true
    bool get(const Key& key, Value& value) override {
        std::lock_guard<std::mutex> lock(m_mutex);
        if (m_hashMap.find(key) == m_hashMap.end()) {
            return false;
        }
        value = m_hashMap[key]->m_value;
        m_iLinkedList.addOldNode(m_hashMap[key]);
        return true;
    }

    // 如果缓存中能找到key，则直接返回value
    Value get(const Key& key) override {
        std::lock_guard<std::mutex> lock(m_mutex);
        if (m_hashMap.find(key) == m_hashMap.end()) {
            return Value{};
        }
        auto value = m_hashMap[key]->m_value;
        m_iLinkedList.addOldNode(m_hashMap[key]);
        return value;
    }
    ~ILruCache() override = default;
};

template <typename Key, typename Value>
class IHashLruCache {
private:
    size_t m_capacity;
    int m_sliceNum;
    std::vector<std::unique_ptr<ILruCache<Key, Value>>> m_lruSliceCaches;
    size_t Hash(const Key& key) {
        std::hash<Key> keyHash;
        return keyHash(key);
    }

public:
    IHashLruCache(const size_t& capacity, const int& sliceNum)
        : m_capacity(capacity),
          m_sliceNum(sliceNum > 0 ? sliceNum
                     : std::thread::hardware_concurrency() > 0
                         ? std::thread::hardware_concurrency()
                         : 1) {
        // 下列实现方法可能会导致总容量超过capacity
        // size_t sliceSize =
        //     std::ceil(capacity / static_cast<double>(m_sliceNum));
        // for (int i = 0; i < m_sliceNum; i++) {
        //     m_lruSliceCaches.emplace_back(
        //         std::make_unique<ILruCache<Key, Value>>(sliceSize));
        // }

        size_t baseSize = capacity / m_sliceNum;
        size_t remainder = capacity % m_sliceNum;
        for (int i = 0; i < m_sliceNum; i++) {
            size_t size = baseSize;
            if (i < remainder) {
                size += 1;
            }
            m_lruSliceCaches.emplace_back(
                std::make_unique<ILruCache<Key, Value>>(size));
        }
    }

    // 添加缓存接口
    void put(const Key& key, const Value& value) {
        if(m_capacity <= 0) return;
        size_t hashValue = Hash(key) % m_sliceNum;
        m_lruSliceCaches[hashValue]->put(key, value);
    }

    // key是传入参数  访问到的值以传出参数的形式返回 | 访问成功返回true
    bool get(const Key& key, Value& value) {
        size_t hashValue = Hash(key) % m_sliceNum;
        return m_lruSliceCaches[hashValue]->get(key, value);
    }

    // 如果缓存中能找到key，则直接返回value
    Value get(const Key& key) {
        size_t hashValue = Hash(key) % m_sliceNum;
        return m_lruSliceCaches[hashValue]->get(key);
    }
};

}  // namespace ICache