//
//  LeetCode_515.swift
//  LeetCode
//
//  Created by Du on 2021/1/30.
//  Copyright © 2021 Du. All rights reserved.
//

import Foundation
/**
 题目：
 515. 在每个树行中找最大值
 您需要在二叉树的每一行中找到最大的值。
 */


/********************解题********************/
class Solution_515 {
    func largestValues(_ root: TreeNode?) -> [Int] {
        guard let rootNode = root else {
            return []
        }
        
        var queue: [TreeNode] = [rootNode]
        var largestArray = [Int]()
        while !queue.isEmpty {
            let size = queue.count
            var maxSum = Int.min
            for i in 0..<size {
                let firstNode = queue.removeFirst()
                // 在这个循环里面，就是遍历同一层的节点，所以找出最大值就行
                maxSum = max(maxSum, firstNode.val)
                
                if i == (size - 1) {//遍历完同一层的时候，才把最大值加到数组里面
                    largestArray.append(maxSum)
                }
                
                if let leftNode = firstNode.left {
                    queue.append(leftNode)
                }
                
                if let rightNode = firstNode.right {
                    queue.append(rightNode)
                }
            }
        }
        return largestArray
    }
}


/********************测试代码********************/
extension Solution_515 {
    func solution_515_test(_ node: TreeNode?) {
        let resultArray = self.largestValues(node)
        print(resultArray)
    }
}
