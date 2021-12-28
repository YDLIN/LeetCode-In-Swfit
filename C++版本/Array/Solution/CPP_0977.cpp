//
//  CPP_0977.cpp
//  LeetCode
//
//  Created by Du on 2021/12/28.
//  Copyright © 2021 Du. All rights reserved.
//

#include "CPP_0977.hpp"
#include <iostream>


vector<int> CPP_0977::sortedSquares(vector<int> &nums) {
    int k = nums.size() - 1;
    vector<int> result(nums.size(), 0);
    
    for (int i = 0, j = nums.size() - 1; i <= j;) {
        if (nums[i] *nums[i] < nums[j] *nums[j]) {
            result[k--] = nums[j] *nums[j];
            --j;
        } else {
            result[k--] = nums[i] *nums[i];
            ++i;
        }
    }
    
    
    for (auto i = result.begin(); i != result.end(); ++i) {
        cout << *i << endl;
    }
    
    return result;
}
