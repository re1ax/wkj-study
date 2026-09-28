#include <iostream>
#include <vector>
#include <unordered_map>
#include <map>

// Leetcode 49
class Solution {
public:
    std::vector<std::vector<std::string>> groupAnagrams(
        std::vector<std::string>& strs) {
            std::vector<std::vector<std::string>> ans;
            std::map<std::map<char, int>, std::vector<std::string>> hashMap;
            for(std::string str : strs) {
                std::map<char, int> count;
                for(int i = 0; i < str.size(); i++) {
                    if(count.find(str[i]) != count.end()) {
                        count[str[i]]++;
                    }else {
                        count[str[i]] = 1;
                    }
                }
                hashMap[count].push_back(str);
            }
            for(auto it : hashMap) {
                ans.push_back(it.second);
            }
            return ans;
        }
};

int main() {
    std::ios::sync_with_stdio(false);
    std::cin.tie(nullptr);

    Solution solution;

    return 0;
}
