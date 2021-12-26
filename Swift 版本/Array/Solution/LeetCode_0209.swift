//
//  LeetCode_209.swift
//  LeetCode
//
//  Created by 余杜林 on 2021/2/2.
//  Copyright © 2021 Du. All rights reserved.
//

import Foundation
/**
 题目：
 209. 长度最小的子数组
 给定一个含有 n 个正整数的数组和一个正整数 s ，找出该数组中满足其和 ≥ s 的长度最小的 连续 子数组，并返回其长度。如果不存在符合条件的子数组，返回 0。

 示例：
 输入：s = 7, nums = [2,3,1,2,4,3]
 输出：2
 解释：子数组 [4,3] 是该条件下的长度最小的子数组。
 */


/********************解题********************/
class Solution_0209 {
    // [5, 1, 3, 5, 10, 7, 4, 9, 2, 8]
    func minSubArrayLen(_ target: Int, _ nums: [Int]) -> Int {
        // 在每次窗口移动过程中，用来保存最小的窗口长度
        // 因为在移动中，后面的windowLen可能会比前面的windowLen的要大，这样我们最后就要返回前面的最小值就行了
        var result = Int.max
        // 滑动窗口内数值总和
        var sum = 0
        // 滑动窗口开始位置
        var starIndex = 0
        // 滑动窗口的长度（会变化的）
        var windowLen = 0
        
        // endIndex: 滑动窗口结束位置
        for endIndex in 0..<nums.count {
            sum += nums[endIndex]
            
            while sum >= target {// 如果子数组的总和≥给定的target，则缩短滑动窗口的长度，以便得出最小的连续子数组
                // 更新滑动窗口的长度
                windowLen = endIndex - starIndex + 1

                result = result < windowLen ? result : windowLen
//                result = min(result, endIndex - starIndex + 1)
                
                // 缩短滑动窗口后，需要重新计算窗口内数值总和
                sum -= nums[starIndex]
                // 如果还能进来循环，证明缩小窗口后，窗口里面的值还是≥target，那就需要继续缩短滑动窗口的长度
                starIndex += 1
            }
        }
        
        return result == Int.max ? 0 : result
    }
}

/********************测试代码********************/
extension Solution_0209 {
    func solution_0209_test(_ target: Int, _ nums: [Int]) {
        print(self.minSubArrayLen(target, nums))
    }
}
