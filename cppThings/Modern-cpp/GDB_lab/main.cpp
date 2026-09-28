#include <iostream>
#include <vector>

int main() {
    std::vector<int> nums = {10, 20, 30};

    int sum = 0;

    for (int i = 0; i <= nums.size(); ++i) {
        sum += nums[i];
    }

    std::cout << "sum = " << sum << std::endl;

    return 0;
}