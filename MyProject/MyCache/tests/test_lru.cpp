#include <iostream>
#include <cassert>
#include <string>

#include "LruCache.h"

void testPutAndGet() {
    ICache::ILruCache<int, std::string> cache(2);

    int key = 1;
    std::string value = "one";
    cache.put(key, value);

    std::string result;
    assert(cache.get(key, result));
    assert(result == "one");
}

void testMissingKey() {
    ICache::ILruCache<int, std::string> cache(2);

    int key = 1;
    std::string result;
    assert(!cache.get(key, result));
}

void testEvictLeastRecentlyUsed() {
    ICache::ILruCache<int, std::string> cache(2);

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

void testGetMakesKeyRecentlyUsed() {
    ICache::ILruCache<int, std::string> cache(2);

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

void testUpdateExistingKey() {
    ICache::ILruCache<int, std::string> cache(2);

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

int main() {
    testPutAndGet();
    testMissingKey();
    testEvictLeastRecentlyUsed();
    testGetMakesKeyRecentlyUsed();
    testUpdateExistingKey();

    std::cout << "All LRU tests passed" << std::endl;
    return 0;
}
