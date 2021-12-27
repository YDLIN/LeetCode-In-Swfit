//
//  CPP_0209.cpp
//  LeetCode
//
//  Created by Du on 2021/12/27.
//  Copyright © 2021 Du. All rights reserved.
//

#include "CPP_0209.hpp"

// 暴力解法
int CPP_0209::minSubArrayLen(vector<int>& nums, int target) {
    int result = INT_MAX;
    int sum = 0;
    int subLen = 0;
    for (int i = 0; i < nums.size(); ++i) {
        sum = 0;
        for (int j = i; j < nums.size(); ++j) {
            sum += nums[j];
            if (sum >= target) {
                subLen = j - i + 1;
                result = (result < subLen) ? result : subLen;
                break;
            }
        }
    }
    return result == INT_MAX ? 0 : result;
}

// 双指针法
int CPP_0209::minSubArrayLen_2(vector<int>& nums, int target) {
    int result = INT_MAX;
    int sum = 0;
    int i = 0;
    int subLen = 0;
    for (int j = 0; j < nums.size(); ++j) {
        sum += nums[j];
        while (sum >= target) {
            subLen = j - i + 1;
            result = result < subLen ? result : subLen;
            sum -= nums[i++];
        }
    }
    return result == INT_MAX ? 0 : result;
}
