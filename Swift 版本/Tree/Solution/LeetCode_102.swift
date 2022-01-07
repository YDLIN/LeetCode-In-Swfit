//
//  LeetCode_102.swift
//  LeetCode
//
//  Created by Du on 2021/1/27.
//  Copyright © 2021 Du. All rights reserved.
//

import Foundation
/**
 题目：
 102. 二叉树的层序遍历
 给你一个二叉树，请你返回其按 层序遍历 得到的节点值。（即逐层地，从左到右访问所有节点）。
 */


/********************解题********************/
class Solution_102 {
    func levelOrderTraversal(_ root: TreeNode?) -> [[Int]] {
        guard let rootNode = root else {
            return []
        }
        
        var resultArray = [[Int]]()
        var queue: [TreeNode] = [rootNode]
        
        while !queue.isEmpty {
            var levelArray = [Int]()
            let size = queue.count
            for _ in 0..<size {
                let firstNode = queue.removeFirst()
                levelArray.append(firstNode.val)
                
                if let leftNode = firstNode.left {
                    queue.append(leftNode)
                }
                
                if let rightNode = firstNode.right {
                    queue.append(rightNode)
                }
            }
            resultArray.append(levelArray)
        }
        return resultArray
    }
}


/********************测试代码********************/
extension Solution_102 {
    func solution_102_test(_ node: TreeNode?) {
        print(levelOrderTraversal(node))
    }
}
