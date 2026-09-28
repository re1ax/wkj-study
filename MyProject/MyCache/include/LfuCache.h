#pragma once
#include <limits.h>

#include <cmath>  //hash函数
#include <iterator>
#include <list>
#include <memory>
#include <mutex>
#include <thread>
#include <unordered_map>
#include <vector>

#include <stdexcept>

#include "ICachePolicy.h"

namespace ICache {

template <typename Key, typename Value>
struct ILfuNode;

template <typename Key, typename Value>
class ILfuCache;

template <typename Key, typename Value>
struct ILfuNode {
    Key m_key;
    Value m_value;
    int m_count;
    ILfuNode(Key&& key, Value&& value)
        : m_key(std::move(key)), m_value(std::move(value)), m_count(1) {}

    ILfuNode(const Key& key, const Value& value)
        : m_key(key), m_value(value), m_count(1) {}

    bool operator<(const ILfuNode<Key, Value>& other) const {
        return m_count < other.m_count;
    }
};

template <typename Key, typename Value>
class ILfuCache : public ICachePolicy<Key, Value> {
private:
    using Node = ILfuNode<Key, Value>;
    using NodePtr = std::shared_ptr<Node>;

    using KeyList = std::list<Key>;

    using NodeMap = std::unordered_map<Key, NodePtr>;
    using FreqMap = std::unordered_map<int, KeyList>;
    using IterMap = std::unordered_map<Key, typename KeyList::iterator>;
    int m_capacity;
    int m_size;
    int m_minFreq;
    NodeMap m_nodeMap;
    FreqMap m_freqMap;                          // 记录每个访问次数对应的keyList
    std::unordered_map<Key, int> m_keyFreqMap;  // 记录每个key的访问次数
    IterMap m_iterMap;
    std::mutex m_mutex;

    // Aging
    bool m_enableAging;
    // 是否启用老化
    int m_maxAverageFreq;
    // 老化阈值
    int m_curTotalFreq;
    // 当前总频率

    void deleteMinFreNode() {
        auto& keyList = m_freqMap[m_minFreq];

        // 删除链表头部元素
        Key frontKey = keyList.front();
        keyList.pop_front();
        // 删除m_nodeMap对应节点
        m_nodeMap.erase(frontKey);
        // 删除m_keyFreqMap对应节点
        m_keyFreqMap.erase(frontKey);
        // 删除m_iterMap对应节点
        m_iterMap.erase(frontKey);

        if (m_enableAging) {
            m_curTotalFreq -= m_minFreq;
        }

        if (keyList.size() == 0) {
            m_freqMap.erase(this->m_minFreq);
            // 更新最小频率
            int tempMinFre = INT32_MAX;
            for (auto it = m_freqMap.begin(); it != m_freqMap.end(); it++) {
                if (tempMinFre > it->first) tempMinFre = it->first;
            }
            this->m_minFreq = tempMinFre;
        }
        m_size--;
    }

    void addNewNode(NodePtr newNode) {
        m_nodeMap[newNode->m_key] = newNode;
        m_keyFreqMap[newNode->m_key] = 1;
        if (m_freqMap.find(1) == m_freqMap.end()) {
            m_freqMap[1] = KeyList();
        }
        m_freqMap[1].push_back(newNode->m_key);
        m_iterMap[newNode->m_key] = std::prev(m_freqMap[1].end());
        m_minFreq = 1;
        m_size++;
        if (m_enableAging) {
            m_curTotalFreq++;
        }
    }

    void increFreq(const Key& key) {
        int count = m_keyFreqMap[key];
        KeyList& keyList = m_freqMap[count];
        keyList.erase(m_iterMap[key]);
        if (keyList.size() == 0) {
            m_freqMap.erase(count);
            if (count == m_minFreq) {
                this->m_minFreq = count + 1;
            }
        }
        int newCount = count + 1;
        if (m_freqMap.find(newCount) == m_freqMap.end()) {
            KeyList newCountList;
            newCountList.push_back(key);
            m_freqMap[newCount] = newCountList;
        } else {
            m_freqMap[newCount].push_back(key);
        }
        auto& node = m_nodeMap[key];
        m_iterMap[key] = std::prev(m_freqMap[newCount].end());
        node->m_count = newCount;
        m_keyFreqMap[key] = newCount;
        if (m_enableAging) {
            m_curTotalFreq++;
            if (m_curTotalFreq / m_size >= m_maxAverageFreq) {
                rebuildFrequency();
            }
        }
    }

    void rebuildFrequency() {
        // 更新
        /**
         *
         * m_nodeMap;
         * m_freqMap; //
         * m_keyFreqMap;  // 记录每个key的访问次数 std::unordered_map<Key,
         * m_iterMap;
         * m_curTotalFreq
         * m_size
         */

        // m_nodeMap;
        FreqMap newFreqMap;
        IterMap newIterMap;
        int newTotalFreq = 0;
        int newMinFreq = INT_MAX;
        for (auto& singleFreqMap : m_freqMap) {
            int oldFreq = singleFreqMap.first;
            int newFreq = std::max(1, oldFreq - 1);
            for (auto& listNode : singleFreqMap.second) {
                newFreqMap[newFreq].push_back(listNode);
                newIterMap[listNode] = std::prev(newFreqMap[newFreq].end());
                m_keyFreqMap[listNode] = newFreq;
                m_nodeMap[listNode]->m_count = newFreq;
                newTotalFreq += newFreq;
            }
            newMinFreq = std::min(newMinFreq, newFreq);
        }
        m_freqMap = std::move(newFreqMap);
        m_iterMap = std::move(newIterMap);
        m_curTotalFreq = newTotalFreq;
        m_minFreq = newMinFreq;
    }

public:
    ILfuCache(int capacity)
        : m_capacity(capacity),
          m_size(0),
          m_minFreq(0),
          m_enableAging(false),
          m_maxAverageFreq(0),
          m_curTotalFreq(0) {}
    ILfuCache(int capacity, int maxAverageFreq)
        : m_capacity(capacity),
          m_size(0),
          m_minFreq(0),
          m_enableAging(true),
          m_maxAverageFreq(maxAverageFreq),
          m_curTotalFreq(0) {
        if (maxAverageFreq <= 0) {
            throw std::invalid_argument("maxAverageFreq must be greater than 0");
        }
    }
    // 添加缓存接口
    void put(const Key& key, const Value& value) override {
        std::lock_guard<std::mutex> lock(m_mutex);
        if (m_capacity <= 0) return;
        if (m_nodeMap.find(key) != m_nodeMap.end()) {
            m_nodeMap[key]->m_value = value;
            increFreq(key);
        } else {
            auto node = std::make_shared<Node>(key, value);
            if (m_size >= m_capacity) {
                deleteMinFreNode();
            }
            addNewNode(node);
        }
    }

    // key是传入参数  访问到的值以传出参数的形式返回 | 访问成功返回true
    bool get(const Key& key, Value& value) override {
        std::lock_guard<std::mutex> lock(m_mutex);
        if (m_nodeMap.find(key) == m_nodeMap.end()) {
            value = Value{};
            return false;
        }
        increFreq(key);
        value = m_nodeMap[key]->m_value;
        return true;
    }

    // 如果缓存中能找到key，则直接返回value
    Value get(const Key& key) override {
        std::lock_guard<std::mutex> lock(m_mutex);
        if (m_nodeMap.find(key) == m_nodeMap.end()) {
            return Value{};
        }
        increFreq(key);
        return m_nodeMap[key]->m_value;
    }
};

// Lfu的Hash优化
template <typename Key, typename Value>
class IHashLfuCache {
private:
    size_t m_capacity;
    int m_sliceNum;
    std::vector<std::unique_ptr<ILfuCache<Key, Value>>> m_lfuSliceCaches;
    size_t Hash(const Key& key) {
        std::hash<Key> keyHash;
        return keyHash(key);
    }

public:
    IHashLfuCache(const size_t& capacity, const int& sliceNum)
        : m_capacity(capacity),
          m_sliceNum(sliceNum > 0 ? sliceNum
                     : std::thread::hardware_concurrency() > 0
                         ? std::thread::hardware_concurrency()
                         : 1) {
        size_t baseSize = m_capacity / m_sliceNum;
        size_t remainder = m_capacity % m_sliceNum;
        for (int i = 0; i < m_sliceNum; i++) {
            size_t size = baseSize;
            if (i < remainder) size += 1;
            m_lfuSliceCaches.emplace_back(
                std::make_unique<ILfuCache<Key, Value>>(size));
        }
    }
    void put(const Key& key, const Value& value) {
        if (m_capacity <= 0) return;
        size_t index = Hash(key) % m_sliceNum;
        m_lfuSliceCaches[index]->put(key, value);
    }

    // key是传入参数  访问到的值以传出参数的形式返回 | 访问成功返回true
    bool get(const Key& key, Value& value) {
        size_t index = Hash(key) % m_sliceNum;
        return m_lfuSliceCaches[index]->get(key, value);
    }

    // 如果缓存中能找到key，则直接返回value
    Value get(const Key& key) {
        size_t index = Hash(key) % m_sliceNum;
        return m_lfuSliceCaches[index]->get(key);
    }
};

template <typename Key, typename Value>
class IAgingLfuCache : public ILfuCache<Key, Value> {
public:
    IAgingLfuCache(int capacity, int maxAverageFreq = 10)
        : ILfuCache<Key, Value>(capacity, maxAverageFreq) {}
};

}  // namespace ICache