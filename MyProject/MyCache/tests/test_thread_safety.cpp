#include <cassert>
#include <iostream>
#include <string>
#include <thread>
#include <vector>

#include "LfuCache.h"
#include "LruCache.h"

template <typename Cache>
void runConcurrentMixedAccess(Cache& cache, int threadCount, int operationsPerThread) {
    std::vector<std::thread> threads;
    threads.reserve(threadCount);

    for (int threadId = 0; threadId < threadCount; ++threadId) {
        threads.emplace_back([&cache, threadId, operationsPerThread]() {
            for (int op = 0; op < operationsPerThread; ++op) {
                int key = (threadId * 97 + op) % 128;
                std::string value =
                    "t" + std::to_string(threadId) + "_v" + std::to_string(op);

                if (op % 3 == 0) {
                    cache.put(key, value);
                } else {
                    std::string result;
                    cache.get(key, result);
                }
            }
        });
    }

    for (auto& thread : threads) {
        thread.join();
    }
}

template <typename Cache>
void verifyCacheStillUsable(Cache& cache) {
    for (int key = 1000; key < 1010; ++key) {
        std::string value = "stable_" + std::to_string(key);
        cache.put(key, value);
    }

    for (int key = 1000; key < 1010; ++key) {
        std::string expected = "stable_" + std::to_string(key);
        std::string result;
        assert(cache.get(key, result));
        assert(result == expected);
    }
}

void testLruThreadSafety() {
    ICache::ILruCache<int, std::string> cache(256);

    runConcurrentMixedAccess(cache, 8, 5000);
    verifyCacheStillUsable(cache);
}

void testLfuThreadSafety() {
    ICache::ILfuCache<int, std::string> cache(256);

    runConcurrentMixedAccess(cache, 8, 5000);
    verifyCacheStillUsable(cache);
}

void testConcurrentSameKeys() {
    ICache::ILruCache<int, std::string> lru(16);
    ICache::ILfuCache<int, std::string> lfu(16);

    std::vector<std::thread> threads;
    for (int threadId = 0; threadId < 8; ++threadId) {
        threads.emplace_back([&lru, &lfu, threadId]() {
            for (int op = 0; op < 2000; ++op) {
                int key = op % 8;
                std::string value =
                    "shared_" + std::to_string(threadId) + "_" + std::to_string(op);
                lru.put(key, value);
                lfu.put(key, value);

                std::string result;
                lru.get(key, result);
                lfu.get(key, result);
            }
        });
    }

    for (auto& thread : threads) {
        thread.join();
    }

    std::string result;
    for (int key = 0; key < 8; ++key) {
        assert(lru.get(key, result));
        assert(lfu.get(key, result));
    }
}

int main() {
    testLruThreadSafety();
    testLfuThreadSafety();
    testConcurrentSameKeys();

    std::cout << "All thread safety tests passed" << std::endl;
    return 0;
}
