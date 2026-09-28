#include <cassert>
#include <iostream>
#include <string>
#include <thread>
#include <vector>

#include "LfuCache.h"

void testPutAndGet() {
    ICache::IHashLfuCache<int, std::string> cache(16, 4);

    cache.put(1, "one");
    cache.put(2, "two");

    std::string result;
    assert(cache.get(1, result));
    assert(result == "one");
    assert(cache.get(2, result));
    assert(result == "two");
}

void testMissingKey() {
    ICache::IHashLfuCache<int, std::string> cache(16, 4);

    std::string result;
    assert(!cache.get(42, result));
}

void testUpdateExistingKey() {
    ICache::IHashLfuCache<int, std::string> cache(16, 4);

    cache.put(1, "one");
    cache.put(1, "ONE");

    std::string result;
    assert(cache.get(1, result));
    assert(result == "ONE");
}

void testZeroCapacity() {
    ICache::IHashLfuCache<int, std::string> cache(0, 4);

    cache.put(1, "one");

    std::string result;
    assert(!cache.get(1, result));
}

void testManyKeysAcrossShards() {
    ICache::IHashLfuCache<int, std::string> cache(128, 8);

    for (int key = 0; key < 64; ++key) {
        cache.put(key, "value_" + std::to_string(key));
    }

    for (int key = 0; key < 64; ++key) {
        std::string result;
        assert(cache.get(key, result));
        assert(result == "value_" + std::to_string(key));
    }
}

void testFrequencyEvictionWithinShard() {
    ICache::IHashLfuCache<int, std::string> cache(2, 1);

    cache.put(1, "one");
    cache.put(2, "two");

    std::string result;
    assert(cache.get(1, result));
    assert(result == "one");

    cache.put(3, "three");

    assert(cache.get(1, result));
    assert(result == "one");
    assert(!cache.get(2, result));
    assert(cache.get(3, result));
    assert(result == "three");
}

void testConcurrentAccess() {
    ICache::IHashLfuCache<int, std::string> cache(256, 8);
    std::vector<std::thread> threads;

    for (int threadId = 0; threadId < 8; ++threadId) {
        threads.emplace_back([&cache, threadId]() {
            for (int op = 0; op < 3000; ++op) {
                int key = (threadId * 101 + op) % 128;
                std::string value =
                    "t" + std::to_string(threadId) + "_v" + std::to_string(op);
                cache.put(key, value);

                std::string result;
                cache.get(key, result);
            }
        });
    }

    for (auto& thread : threads) {
        thread.join();
    }

    for (int key = 1000; key < 1010; ++key) {
        cache.put(key, "stable_" + std::to_string(key));
    }

    for (int key = 1000; key < 1010; ++key) {
        std::string result;
        assert(cache.get(key, result));
        assert(result == "stable_" + std::to_string(key));
    }
}

int main() {
    testPutAndGet();
    testMissingKey();
    testUpdateExistingKey();
    testZeroCapacity();
    testManyKeysAcrossShards();
    testFrequencyEvictionWithinShard();
    testConcurrentAccess();

    std::cout << "All Hash LFU tests passed" << std::endl;
    return 0;
}
