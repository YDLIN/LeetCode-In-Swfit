//
//  LeetCode_035.swift
//  LeetCode
//
//  Created by Du on 2021/2/2.
//  Copyright © 2021 Du. All rights reserved.
//

import Foundation
/**
 题目：
 35. 搜索插入位置
 给定一个排序数组和一个目标值，在数组中找到目标值，并返回其索引。如果目标值不存在于数组中，返回它将会被按顺序插入的位置。
 请必须使用时间复杂度为 O(log n) 的算法。
 */


/********************解题********************/
class Solution_035 {
    /// 暴力法
    func searchInsert_1(_ nums: [Int], _ target: Int) -> Int {
        for i in 0..<nums.count {
            if nums[i] >= target {
                return i
            }
        }
        return nums.count
    }
    
    /// 二分法
    func searchInsert_2(_ nums: [Int], _ target: Int) -> Int {
        // 定义target是在一个左闭右闭[left, right]的区间里
        var left = 0
        var right = nums.count - 1
        
        /*
         1、如果目标值比数组里面所有的值都小，随着多次的while循环，right的值会慢慢的向左走，肯定会出现right < left的情况，
         而又因为left等于0，所以，最后返回的是： right + 1，这样才能插入到数组最开始的位置
         2、如果目标值比数组里面所有的值都大，随着多次的while循环，left的值会慢慢的向右走，肯定会出现left > right的情况，
         而又因为right等于(nums.count - 1)，所以，最后返回的是： right + 1，也就是，数组的长度，这样才能插入到数组的末端
         */
        while left <= right {
            // 区间的中点（防溢出）
            let middle = left + ((right - left) >> 1)
            
            if nums[middle] > target {// 在区间的左侧
                right = middle - 1
            }else if nums[middle] < target {// 在区间的右侧
                left = middle + 1
            }else if nums[middle] == target {
                return middle
            }
        }
        
        return right + 1
    }
}

/********************测试代码********************/
extension Solution_035 {
    func solution_035_test(_ nums: [Int], _ target: Int) {
        print(self.searchInsert_1(nums, target))
    }
}
