//
//  LeetCode_0027.swift
//  LeetCode
//
//  Created by 余杜林 on 2021/2/2.
//  Copyright © 2021 Du. All rights reserved.
//

import Foundation
/**
 题目：
 27. 移除元素
 给你一个数组 nums 和一个值 val，你需要 原地 移除所有数值等于 val 的元素，并返回移除后数组的新长度。
 不要使用额外的数组空间，你必须仅使用 O(1) 额外空间并 原地 修改输入数组。
 元素的顺序可以改变。你不需要考虑数组中超出新长度后面的元素。
 */


/********************解题********************/
class Solution_0027 {
    // 暴力法：
    // [7, 7, 5, 7, 11, 12] size:6
    // [7, 5, 7, 11, 12, 12] size:5
    // [5, 7, 11, 12, 12, 12] size:4
    // [5, 11, 12, 12, 12, 12] size:3
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        var size = nums.count
        // 最外层循环：找到目标值
        for i in 0..<size {
            print(i)
            if nums[i] == val {//找到目标值
                // [i + 1, size - 1]的所有元素，都要向前挪动，覆盖旧值
                for j in (i + 1)..<size {
                    nums[j - 1] = nums[j]
                }
                // 因为目标值后的元素都向前挪动了，所以下标跟着向前挪，需要减1
//                i -= 1
                // 每找到一个目标值，就删除该目标值，所以size需要减1
                size -= 1
            }
        }
        
        // 最终数组的长度是不变的，但是里面的元素变了
        print(nums)
        return size
    }
    
    
    //快慢指针法
    //原数组：     [1, 3, 5, 6, 4, 7, 10, 5, 9, 11]; val = 5
    //移动后的数组：[1, 3, 6, 4, 7, 10, 9, 11, 11, 11]
    func removeElement2(_ nums: inout [Int], _ val: Int) -> Int {
        var slowIndex = 0
        
        for fastIndex in 0..<nums.count {
            if val != nums[fastIndex] {
                // 如果快慢指针不一致，表明之前有找到过目标值
                // 这里判断有优化的作用，如果不判断，就表示在找到第一个目标之前的所有元素都替换一次，是毫无意义的操作
                if slowIndex != fastIndex {
                    // 通过快指针取值来覆盖慢指针的值，才能做到原地修改数组，而不是直接删除目标值
                    nums[slowIndex] = nums[fastIndex]
                }
                // 如果找不到目标值，慢指针也要跟着挪动
                slowIndex += 1
            }
            // 如果找到目标值，那么慢指针不做任何处理，这样导致的结果就是，每次找到一个目标值，慢指针都会比快指针慢一步，所以找到多少个目标值，慢指针就慢多少步;
            // 所以当快指针走完时（for 循环执行完毕），慢指针的值，就是新数组的最终长度
        }
        return slowIndex
    }
}

/********************测试代码********************/
extension Solution_0027 {
    func solution_0027_test(_ nums: inout [Int], _ val: Int) {
        let size = self.removeElement2(&nums, val)
        print(size)
    }
}
