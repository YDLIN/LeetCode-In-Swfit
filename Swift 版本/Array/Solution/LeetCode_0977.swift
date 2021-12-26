//
//  LeetCode_0977.swift
//  LeetCode
//
//  Created by 余杜林 on 2021/8/7.
//  Copyright © 2021 Du. All rights reserved.
//

import Foundation
/**
 题目：
 977. 有序数组的平方
 给你一个按 非递减顺序 排序的整数数组 nums，返回 每个数字的平方 组成的新数组，要求也按 非递减顺序 排序。

 示例 1：
 输入：nums = [-4,-1,0,3,10]
 输出：[0,1,9,16,100]
 解释：平方后，数组变为 [16,1,0,9,100]
 排序后，数组变为 [0,1,9,16,100]
 */


/********************解题********************/
class Solution_0977 {
    func sortedSquares(_ nums: [Int]) -> [Int] {
        // 指向新数组最后一个元素
        var k = nums.count - 1
        // 指向原数组第一个元素
        var i = 0
        // 指向原数组最后一个元素
        var j = nums.count - 1
        // 初始化新数组
        var result = Array<Int>(repeating: -1, count: nums.count)
        
        for _ in 0..<nums.count {
            if nums[i] * nums[i] < nums[j] * nums[j] {
                result[k] = nums[j] * nums[j]
                j -= 1
            } else {
                result[k] = nums[i] * nums[i]
                i += 1
            }
            k -= 1
        }
        
        return result
    }
}

/********************测试代码********************/
extension Solution_0977 {
    func solution_0977_test(_ nums: [Int]) {
        print(self.sortedSquares(nums))
    }
}
