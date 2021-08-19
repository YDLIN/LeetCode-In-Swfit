//
//  LeetCode_0704.swift
//  LeetCode
//
//  Created by Du on 2021/8/5.
//  Copyright © 2021 Du. All rights reserved.
//

import Foundation
/**
 题目：
 704. 二分查找
 给定一个 n 个元素有序的（升序）整型数组 nums 和一个目标值 target  ，写一个函数搜索 nums 中的 target，如果目标值存在返回下标，否则返回 -1。

 示例：
 输入：nums = [-1,0,3,5,9,12], target = 9
 输出：4
 解释：9 出现在 nums 中并且下标为 4
 
 思路🌟：
 前提 -> 有序的数组 + 不重复元素
 一般情况下，有这两种前提条件，可以考虑能不能用二分法去做
 */


/********************解题********************/
class Solution_0704 {
    // （版本一）左闭右闭区间
    func search(nums: [Int], target: Int) -> Int {
        // 1. 先定义区间。这里的区间是[left, right]
        var left = 0
        var right = nums.count - 1
        
        while left <= right {// 因为taeget是在[left, right]中，包括两个边界值，所以这里的left == right是有意义的
            // 2. 计算区间中间的下标（如果left、right都比较大的情况下，left + right就有可能会溢出）
            // let middle = (left + right) / 2
            // 防溢出：
             let middle = left + (right - left) / 2
            
            // 3. 判断
            if target < nums[middle] {
                // 当目标在区间左侧，就需要更新右边的边界值，新区间为[left, middle - 1]
                right = middle - 1
            } else if target > nums[middle] {
                // 当目标在区间右侧，就需要更新左边的边界值，新区间为[middle + 1, right]
                left = middle + 1
            } else {
                // 当目标就是在中间，则返回中间值的下标
                return middle
            }
        }
        
        // 如果找不到目标，则返回-1
        return -1
    }
    
    // （版本二）左闭右开区间
    func search2(nums: [Int], target: Int) -> Int {
        var left = 0
        var right = nums.count
        
        while left < right {
            let middle = left + ((right - left) >> 1)
            
            if target < nums[middle] {
                right = middle
            } else if target > nums[middle] {
                left = middle + 1
            } else {
                return middle
            }
        }
        
        return -1
    }
}

/********************测试代码********************/
extension Solution_0704 {
    func solution_0704_test(_ nums: [Int], _ target: Int) {
        print(self.search(nums: nums, target: target))
    }
}
