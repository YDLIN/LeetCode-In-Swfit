//
//  LeetCode_0637.swift
//  LeetCode
//
//  Created by Du on 2021/1/27.
//  Copyright © 2021 Du. All rights reserved.
//

import Foundation
/**
 题目：
 637. 二叉树的层平均值
 给定一个非空二叉树, 返回一个由每层节点平均值组成的数组。
 */


/********************解题********************/
class Solution_0637 {
    func averageOfLevels(_ root: TreeNode?) -> [Double] {
        guard let root = root else {
            return []
        }
        
        var queue = [root]
        var averageArray = [Double]()
        
        while !queue.isEmpty {
            let size = queue.count
            
            var sum = 0
            for _ in 0..<size {
                let firstNode = queue.removeFirst()
                
                sum += firstNode.val
                
                if let leftNode = firstNode.left {
                    queue.append(leftNode)
                }
                
                if let rightNode = firstNode.right {
                    queue.append(rightNode)
                }
            }
            averageArray.append(Double(sum)/Double(size))
        }
        
        return averageArray
    }
}


/********************测试代码********************/
extension Solution_0637 {
    func test() {
        print(averageOfLevels(tree6Root))
    }
}
