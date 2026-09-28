#include <array>
#include <chrono>
#include <iomanip>
#include <iostream>
#include <random>
#include <string>
#include <vector>

#include "ICachePolicy.h"
#include "LfuCache.h"
#include "LruCache.h"

struct Operation {
    bool isPut;
    int key;
    std::string value;
};

class Timer {
public:
    Timer() : start_(std::chrono::high_resolution_clock::now()) {}

    double elapsedMs() const {
        auto now = std::chrono::high_resolution_clock::now();
        return std::chrono::duration_cast<std::chrono::milliseconds>(now - start_).count();
    }

private:
    std::chrono::time_point<std::chrono::high_resolution_clock> start_;
};

struct CacheResult {
    std::string name;
    int getOperations;
    int hits;
    double elapsedMs;
};

template <typename Cache>
CacheResult runCache(const std::string& name, Cache& cache,
                     const std::vector<int>& warmupKeys,
                     const std::vector<Operation>& operations) {
    int hits = 0;
    int getOperations = 0;

    for (int warmupKey : warmupKeys) {
        std::string value = "warmup" + std::to_string(warmupKey);
        cache.put(warmupKey, value);
    }

    Timer timer;
    for (const auto& op : operations) {
        if (op.isPut) {
            cache.put(op.key, op.value);
        } else {
            std::string result;
            getOperations++;
            if (cache.get(op.key, result)) {
                hits++;
            }
        }
    }

    return {name, getOperations, hits, timer.elapsedMs()};
}

void printResults(const std::string& testName, int capacity,
                  const std::vector<CacheResult>& results) {
    std::cout << "=== " << testName << " 结果汇总 ===" << std::endl;
    std::cout << "缓存大小: " << capacity << std::endl;

    for (const auto& result : results) {
        double hitRate = result.getOperations == 0
                             ? 0.0
                             : 100.0 * result.hits / result.getOperations;
        std::cout << result.name << " - 命中率: " << std::fixed
                  << std::setprecision(2) << hitRate << "% "
                  << "(" << result.hits << "/" << result.getOperations << ")"
                  << ", 耗时: " << result.elapsedMs << " ms" << std::endl;
    }

    std::cout << std::endl;
}

void runScenario(const std::string& testName, int capacity,
                 const std::vector<int>& warmupKeys,
                 const std::vector<Operation>& operations) {
    ICache::ILruCache<int, std::string> lru(capacity);
    ICache::ILfuCache<int, std::string> lfu(capacity);
    ICache::IHashLruCache<int, std::string> hashLru(capacity, 8);
    ICache::IHashLfuCache<int, std::string> hashLfu(capacity, 8);
    ICache::IAgingLfuCache<int, std::string> agingLfu_10(capacity, 10);
    ICache::IAgingLfuCache<int, std::string> agingLfu_100(capacity, 100);
    ICache::IAgingLfuCache<int, std::string> agingLfu_1000(capacity, 1000);

    std::vector<CacheResult> results;
    results.push_back(runCache("LRU", lru, warmupKeys, operations));
    results.push_back(runCache("LFU", lfu, warmupKeys, operations));
    results.push_back(runCache("HashLRU", hashLru, warmupKeys, operations));
    results.push_back(runCache("HashLFU", hashLfu, warmupKeys, operations));
    results.push_back(runCache("AgingLfu_10", agingLfu_10, warmupKeys, operations));
    results.push_back(runCache("AgingLfu_100", agingLfu_100, warmupKeys, operations));
    results.push_back(runCache("AgingLfu_1000", agingLfu_1000, warmupKeys, operations));
    
    printResults(testName, capacity, results);
}

void testHotDataAccess() {
    std::cout << "\n=== 测试场景1：热点数据访问测试 ===" << std::endl;

    const int capacity = 20;
    const int operationsCount = 200000;
    const int hotKeys = 20;
    const int coldKeys = 5000;

    std::mt19937 gen(42);
    std::vector<int> warmupKeys;
    for (int key = 0; key < hotKeys; ++key) {
        warmupKeys.push_back(key);
    }

    std::vector<Operation> operations;
    operations.reserve(operationsCount);
    for (int op = 0; op < operationsCount; ++op) {
        bool isPut = (gen() % 100 < 30);
        int key = 0;
        if (gen() % 100 < 70) {
            key = gen() % hotKeys;
        } else {
            key = hotKeys + (gen() % coldKeys);
        }
        operations.push_back(
            {isPut, key, "value" + std::to_string(key) + "_v" + std::to_string(op % 100)});
    }

    runScenario("热点数据访问测试", capacity, warmupKeys, operations);
}

void testLoopPattern() {
    std::cout << "\n=== 测试场景2：循环扫描测试 ===" << std::endl;

    const int capacity = 50;
    const int loopSize = 500;
    const int operationsCount = 100000;

    std::mt19937 gen(43);
    std::vector<int> warmupKeys;
    for (int key = 0; key < loopSize / 5; ++key) {
        warmupKeys.push_back(key);
    }

    int currentPos = 0;
    std::vector<Operation> operations;
    operations.reserve(operationsCount);
    for (int op = 0; op < operationsCount; ++op) {
        bool isPut = (gen() % 100 < 20);
        int key = 0;
        if (op % 100 < 60) {
            key = currentPos;
            currentPos = (currentPos + 1) % loopSize;
        } else if (op % 100 < 90) {
            key = gen() % loopSize;
        } else {
            key = loopSize + (gen() % loopSize);
        }
        operations.push_back(
            {isPut, key, "loop" + std::to_string(key) + "_v" + std::to_string(op % 100)});
    }

    runScenario("循环扫描测试", capacity, warmupKeys, operations);
}

void testWorkloadShift() {
    std::cout << "\n=== 测试场景3：工作负载剧烈变化测试 ===" << std::endl;

    const int capacity = 30;
    const int operationsCount = 80000;
    const int phaseLength = operationsCount / 5;

    std::mt19937 gen(44);
    std::vector<int> warmupKeys;
    for (int key = 0; key < 30; ++key) {
        warmupKeys.push_back(key);
    }

    std::vector<Operation> operations;
    operations.reserve(operationsCount);
    for (int op = 0; op < operationsCount; ++op) {
        int phase = op / phaseLength;
        int putProbability = 20;
        switch (phase) {
            case 0: putProbability = 15; break;
            case 1: putProbability = 30; break;
            case 2: putProbability = 10; break;
            case 3: putProbability = 25; break;
            case 4: putProbability = 20; break;
            default: putProbability = 20; break;
        }

        bool isPut = (gen() % 100 < putProbability);
        int key = 0;
        if (op < phaseLength) {
            key = gen() % 5;
        } else if (op < phaseLength * 2) {
            key = gen() % 400;
        } else if (op < phaseLength * 3) {
            key = (op - phaseLength * 2) % 100;
        } else if (op < phaseLength * 4) {
            int locality = (op / 800) % 5;
            key = locality * 15 + (gen() % 15);
        } else {
            int r = gen() % 100;
            if (r < 40) {
                key = gen() % 5;
            } else if (r < 70) {
                key = 5 + (gen() % 45);
            } else {
                key = 50 + (gen() % 350);
            }
        }

        operations.push_back(
            {isPut, key, "value" + std::to_string(key) + "_p" + std::to_string(phase)});
    }

    runScenario("工作负载剧烈变化测试", capacity, warmupKeys, operations);
}

void testReadOnlyHotSet() {
    std::cout << "\n=== 测试场景4：纯热点读测试 ===" << std::endl;

    const int capacity = 16;
    const int hotKeys = 16;
    const int operationsCount = 50000;

    std::mt19937 gen(45);
    std::vector<int> warmupKeys;
    for (int key = 0; key < hotKeys; ++key) {
        warmupKeys.push_back(key);
    }

    std::vector<Operation> operations;
    operations.reserve(operationsCount);
    for (int op = 0; op < operationsCount; ++op) {
        int key = gen() % hotKeys;
        operations.push_back({false, key, ""});
    }

    runScenario("纯热点读测试", capacity, warmupKeys, operations);
}

void testScanPollution() {
    std::cout << "\n=== 测试场景5：扫描污染测试 ===" << std::endl;

    const int capacity = 20;
    const int hotKeys = 10;
    const int scanKeys = 2000;

    std::vector<int> warmupKeys;
    for (int key = 0; key < hotKeys; ++key) {
        warmupKeys.push_back(key);
    }

    std::vector<Operation> operations;
    operations.reserve(scanKeys * 2);
    for (int round = 0; round < 20; ++round) {
        for (int key = 0; key < hotKeys; ++key) {
            operations.push_back({false, key, ""});
        }
    }

    for (int key = 1000; key < 1000 + scanKeys; ++key) {
        operations.push_back({true, key, "scan" + std::to_string(key)});
        if (key % 4 == 0) {
            operations.push_back({false, key, ""});
        }
        operations.push_back({false, key % hotKeys, ""});
    }

    for (int round = 0; round < 20; ++round) {
        for (int key = 0; key < hotKeys; ++key) {
            operations.push_back({false, key, ""});
        }
    }

    runScenario("扫描污染测试", capacity, warmupKeys, operations);
}

void testTinyCapacity() {
    std::cout << "\n=== 测试场景6：极小容量测试 ===" << std::endl;

    const int capacity = 1;
    const int operationsCount = 20000;

    std::vector<int> warmupKeys = {0};
    std::vector<Operation> operations;
    operations.reserve(operationsCount);

    for (int op = 0; op < operationsCount; ++op) {
        int key = op % 2;
        bool isPut = (op % 5 == 0);
        operations.push_back(
            {isPut, key, "tiny" + std::to_string(key) + "_v" + std::to_string(op)});
    }

    runScenario("极小容量测试", capacity, warmupKeys, operations);
}

void testZeroCapacity() {
    std::cout << "\n=== 测试场景7：零容量边界测试 ===" << std::endl;

    const int capacity = 0;
    const int operationsCount = 1000;

    std::vector<int> warmupKeys;
    std::vector<Operation> operations;
    operations.reserve(operationsCount);
    for (int op = 0; op < operationsCount; ++op) {
        int key = op % 20;
        bool isPut = (op % 2 == 0);
        operations.push_back({isPut, key, "zero" + std::to_string(key)});
    }

    runScenario("零容量边界测试", capacity, warmupKeys, operations);
}

int main() {
    testHotDataAccess();
    testLoopPattern();
    testWorkloadShift();
    testReadOnlyHotSet();
    testScanPollution();
    testTinyCapacity();
    testZeroCapacity();
    return 0;
}
