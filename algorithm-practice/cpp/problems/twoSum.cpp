#include <iostream>
#include <vector>
#include <unordered_map>

//Leetcode 1

class Solution {
public:
    std::vector<int> twoSum(std::vector<int>& nums, int target) {
        std::unordered_map<int, int> hashMap;
        for(int i = 0; i < nums.size(); i++) {
            if(hashMap.find(target - nums[i]) != hashMap.end()) {
                return {i, hashMap[target - nums[i]]};
            }
            hashMap[nums[i]] = i;
        }
        return {};
    }
};

int main() {
    std::ios::sync_with_stdio(false);
    std::cin.tie(nullptr);

    Solution solution;

    return 0;
}

