//
//  CPP_0704.cpp
//  LeetCode
//
//  Created by Du on 2021/12/26.
//  Copyright © 2021 Du. All rights reserved.
//

#include "CPP_0704.hpp"

// （版本一）左闭右闭区间
int CPP_0704::search(vector<int>& nums, int target) {
    int left = 0;
    int right = nums.size() - 1;
    while (left <= right) {
        int middle = left + ((right - left) / 2);
        if (nums[middle] > target) {//目标在左区间
            right = middle - 1;
        } else if (nums[middle] < target) {//目标在右区间
            left = middle + 1;
        } else {
            return middle;
        }
    }
    return -1;
}

// （版本二）左闭右开区间
int CPP_0704::search_2(vector<int>& nums, int target) {
    int left = 0;
    int right = nums.size();
    while (left < right) {
        int middle = left + ((right - left) / 2);
        if (nums[middle] > target) {//目标在左区间
            right = middle;
        } else if (nums[middle] < target) {//目标在右区间
            left = middle + 1;
        } else {
            return middle;
        }
    }
    return -1;
}
