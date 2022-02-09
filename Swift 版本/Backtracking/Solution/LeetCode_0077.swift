//
//  LeetCode_0077.swift
//  LeetCode
//
//  Created by Du on 2022/2/9.
//  Copyright © 2022 Du. All rights reserved.
//

import Foundation
/**
 题目：
 0077. 组合
 给定两个整数 n 和 k，返回范围 [1, n] 中所有可能的 k 个数的组合。
 你可以按 任何顺序 返回答案。
 */


/********************解题********************/
class Solution_0077 {
    // 存放符合条件结果的集合
    var result = [[Int]]()
    // 存放符合条件结果
    var path = [Int]()
    
    func backTracking(_ n: Int, _ k: Int, _ startIndex: Int) {
        // 终止条件
        // 找到组合长度等于 k 就结束
        if path.count == k {
            print("找到一个满足条件的组合：\(path)")
            result.append(path)
            return
        }
        // 包含了剪枝优化
        print("需要遍历的区间是：[\(startIndex), \(n - (k - path.count) + 1)]")
        for i in startIndex...n - (k - path.count) + 1 {
            print("现在 path 是：\(path)，准备加上\(i)")
            path.append(i)
            backTracking(n, k, i + 1)
            let last = path.removeLast()
            print("回撤\(last)")
        }
    }
    
    
    func combine(_ n: Int, _ k: Int) -> [[Int]] {
        backTracking(n, k, 1)
        return result
    }
}

/********************测试代码********************/
extension Solution_0077 {
    func test() {
        print(combine(4, 3))
    }
}
