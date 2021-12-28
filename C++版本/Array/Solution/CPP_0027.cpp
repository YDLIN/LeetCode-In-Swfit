//
//  CPP_0027.cpp
//  LeetCode
//
//  Created by Du on 2021/12/26.
//  Copyright © 2021 Du. All rights reserved.
//

#include "CPP_0027.hpp"
//#include <iostream>

// 暴力解法
int CPP_0027::removeElement(vector<int>& nums, int val) {
    int size = nums.size();
    for (int i = 0; i < size; ++i) {
        if (nums[i] == val) {
            for (int j = i + 1; j < size; ++j) {
                nums[j - 1] = nums[j];
            }
            --i;
            --size;
        }
    }
    return size;
}

// 双指针法
int CPP_0027::removeElement_2(vector<int>& nums, int val) {
    int slowIndex = 0;
    for (int fastIndex = 0; fastIndex < nums.size(); ++fastIndex) {
        if (nums[fastIndex] != val) {
            nums[slowIndex++] = nums[fastIndex];
        }
    }
    return slowIndex;
}
