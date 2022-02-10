//
//  LeetCode_0216.swift
//  LeetCode
//
//  Created by Du on 2022/2/10.
//  Copyright © 2022 Du. All rights reserved.
//

import Foundation
/**
 题目：
 0216. 组合总和 III
 找出所有相加之和为 n 的 k 个数的组合。组合中只允许含有 1 - 9 的正整数，并且每种组合中不存在重复的数字。

 说明：
 1、所有数字都是正整数。
 2、解集不能包含重复的组合。
 */


/********************解题********************/
class Solution_0216 {
    // 存放符合条件结果的集合
    var result = [[Int]]()
    // 存放符合条件结果
    var path = [Int]()
    
    /// 回溯搜索法
    /// - Parameters:
    ///   - k: 符合条件的集合的个数
    ///   - targetSum: 目标和
    ///   - sum: 已经收集的元素的和
    ///   - startIndex: 下层 for 循环的开始位置
    func backTracking(_ k: Int, _ targetSum: Int, _ sum: Int, _ startIndex: Int) {
        var sum = sum
        // 剪枝
        if sum > targetSum {
            return
        }
        // 终止条件
        // 找到组合长度等于 k，且组合之和等于 target 就加到 result 中
        if path.count == k {
            if sum == targetSum {
                result.append(path)
            }
            // 如果path.count() == k 但sum != targetSum 直接返回
            return
        }
        // 搜索起点和当前还需要选几个数有关，而当前还需要选几个数与已经选了几个数有关
        /*
         所以：搜索起点的上界 + 接下来要选择的元素个数 - 1 = n
         而且：接下来要选择的元素个数 = k - path.size()
         所以：搜索起点的上界 = n - (k - path.size()) + 1
         */
        
        for i in stride(from: startIndex, through: 9 - (k - path.count) + 1, by: 1) {
            sum += i
            path.append(i)
            backTracking(k, targetSum, sum, i + 1)
            sum -= i
            path.removeLast()
        }
    }
    
    
    /// 查找
    /// - Parameters:
    ///   - k: 符合条件的集合的个数
    ///   - n: 目标和
    /// - Returns: 符合要求的组合集合
    func combinationSum3(_ k: Int, _ n: Int) -> [[Int]] {
        backTracking(k, n, 0, 1)
        return result
    }
}

/********************测试代码********************/
extension Solution_0216 {
    func test() {
        print(combinationSum3(2, 4))
    }
}
