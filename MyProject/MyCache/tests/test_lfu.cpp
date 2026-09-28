#include <cassert>
#include <iostream>
#include <string>

#include "LfuCache.h"

void testPutAndGet() {
    ICache::ILfuCache<int, std::string> cache(2);

    int key = 1;
    std::string value = "one";
    cache.put(key, value);

    std::string result;
    assert(cache.get(key, result));
    assert(result == "one");
}

void testMissingKey() {
    ICache::ILfuCache<int, std::string> cache(2);

    int key = 1;
    std::string result;
    assert(!cache.get(key, result));
}

void testEvictLeastFrequentlyUsed() {
    ICache::ILfuCache<int, std::string> cache(2);

    int key1 = 1;
    int key2 = 2;
    int key3 = 3;
    std::string value1 = "one";
    std::string value2 = "two";
    std::string value3 = "three";

    cache.put(key1, value1);
    cache.put(key2, value2);

    std::string result;
    assert(cache.get(key1, result));
    assert(result == "one");

    cache.put(key3, value3);

    assert(cache.get(key1, result));
    assert(result == "one");
    assert(!cache.get(key2, result));
    assert(cache.get(key3, result));
    assert(result == "three");
}

void testEvictOldestWhenFrequencyTies() {
    ICache::ILfuCache<int, std::string> cache(2);

    int key1 = 1;
    int key2 = 2;
    int key3 = 3;
    std::string value1 = "one";
    std::string value2 = "two";
    std::string value3 = "three";

    cache.put(key1, value1);
    cache.put(key2, value2);
    cache.put(key3, value3);

    std::string result;
    assert(!cache.get(key1, result));
    assert(cache.get(key2, result));
    assert(result == "two");
    assert(cache.get(key3, result));
    assert(result == "three");
}

void testUpdateExistingKeyIncreasesFrequency() {
    ICache::ILfuCache<int, std::string> cache(2);

    int key1 = 1;
    int key2 = 2;
    int key3 = 3;
    std::string value1 = "one";
    std::string value2 = "two";
    std::string updatedValue1 = "ONE";
    std::string value3 = "three";

    cache.put(key1, value1);
    cache.put(key2, value2);
    cache.put(key1, updatedValue1);
    cache.put(key3, value3);

    std::string result;
    assert(cache.get(key1, result));
    assert(result == "ONE");
    assert(!cache.get(key2, result));
    assert(cache.get(key3, result));
    assert(result == "three");
}

void testZeroCapacity() {
    ICache::ILfuCache<int, std::string> cache(0);

    int key = 1;
    std::string value = "one";
    cache.put(key, value);

    std::string result;
    assert(!cache.get(key, result));
}

void testNegativeCapacity() {
    ICache::ILfuCache<int, std::string> cache(-1);

    cache.put(1, "one");

    std::string result;
    assert(!cache.get(1, result));
}

int main() {
    testPutAndGet();
    testMissingKey();
    testEvictLeastFrequentlyUsed();
    testEvictOldestWhenFrequencyTies();
    testUpdateExistingKeyIncreasesFrequency();
    testZeroCapacity();
    testNegativeCapacity();

    std::cout << "All LFU tests passed" << std::endl;
    return 0;
}
