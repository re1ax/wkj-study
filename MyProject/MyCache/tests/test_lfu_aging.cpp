#include <cassert>
#include <iostream>
#include <stdexcept>
#include <string>
#include <thread>
#include <vector>

#include "LfuCache.h"

void testPutAndGet() {
    ICache::ILfuCache<int, std::string> cache(2, 3);

    cache.put(1, "one");

    std::string result;
    assert(cache.get(1, result));
    assert(result == "one");
    assert(!cache.get(2, result));
}

void testUpdateExistingKey() {
    ICache::ILfuCache<int, std::string> cache(2, 3);

    cache.put(1, "one");
    cache.put(1, "ONE");

    std::string result;
    assert(cache.get(1, result));
    assert(result == "ONE");
}

void testFrequencyBucketsMergeDuringAging() {
    ICache::ILfuCache<int, std::string> cache(3, 2);

    cache.put(1, "one");
    cache.put(2, "two");
    cache.put(3, "three");

    std::string result;
    assert(cache.get(1, result));
    assert(cache.get(1, result));

    // This access triggers aging. The old frequency-1 and frequency-2
    // buckets both become frequency 1 and must be merged without losing keys.
    assert(cache.get(2, result));

    assert(cache.get(1, result) && result == "one");
    assert(cache.get(2, result) && result == "two");
    assert(cache.get(3, result) && result == "three");
}

void testRepeatedAgingKeepsCacheUsable() {
    ICache::ILfuCache<int, std::string> cache(3, 2);

    cache.put(1, "one");
    cache.put(2, "two");
    cache.put(3, "three");

    const std::vector<std::string> expected = {"", "one", "two", "three"};
    for (int operation = 0; operation < 3000; ++operation) {
        int key = operation % 3 + 1;
        std::string result;
        assert(cache.get(key, result));
        assert(result == expected[key]);
    }
}

void testNewHotKeyCanReplaceOldHotKey() {
    ICache::ILfuCache<int, std::string> cache(2, 3);

    cache.put(1, "old_hot");
    cache.put(2, "new_hot");

    std::string result;
    for (int access = 0; access < 20; ++access) {
        assert(cache.get(1, result));
    }

    // Repeated aging limits the permanent advantage of key 1. Once key 2
    // becomes the new hotspot, key 1 eventually falls to the minimum frequency.
    for (int access = 0; access < 5; ++access) {
        assert(cache.get(2, result));
    }

    cache.put(3, "three");

    assert(!cache.get(1, result));
    assert(cache.get(2, result) && result == "new_hot");
    assert(cache.get(3, result) && result == "three");
}

void testZeroCapacity() {
    ICache::ILfuCache<int, std::string> cache(0, 3);

    cache.put(1, "one");

    std::string result;
    assert(!cache.get(1, result));
}

void testInvalidAverageFrequency() {
    bool coreThrew = false;
    try {
        ICache::ILfuCache<int, std::string> cache(2, 0);
    } catch (const std::invalid_argument&) {
        coreThrew = true;
    }
    assert(coreThrew);

    bool wrapperThrew = false;
    try {
        ICache::IAgingLfuCache<int, std::string> cache(2, -1);
    } catch (const std::invalid_argument&) {
        wrapperThrew = true;
    }
    assert(wrapperThrew);
}

void testConcurrentAgingAccess() {
    ICache::ILfuCache<int, std::string> cache(256, 4);
    std::vector<std::thread> threads;

    for (int threadId = 0; threadId < 8; ++threadId) {
        threads.emplace_back([&cache, threadId]() {
            for (int operation = 0; operation < 3000; ++operation) {
                int key = (threadId * 97 + operation) % 128;
                cache.put(key, "value_" + std::to_string(key));

                std::string result;
                assert(cache.get(key, result));
                assert(result == "value_" + std::to_string(key));
            }
        });
    }

    for (auto& thread : threads) {
        thread.join();
    }

    for (int key = 0; key < 128; ++key) {
        std::string result;
        assert(cache.get(key, result));
        assert(result == "value_" + std::to_string(key));
    }
}

int main() {
    testPutAndGet();
    testUpdateExistingKey();
    testFrequencyBucketsMergeDuringAging();
    testRepeatedAgingKeepsCacheUsable();
    testNewHotKeyCanReplaceOldHotKey();
    testZeroCapacity();
    testInvalidAverageFrequency();
    testConcurrentAgingAccess();

    std::cout << "All Aging LFU tests passed" << std::endl;
    return 0;
}
