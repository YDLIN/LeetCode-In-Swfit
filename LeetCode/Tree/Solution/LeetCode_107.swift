//
//  LeetCode_107.swift
//  LeetCode
//
//  Created by Du on 2021/1/27.
//  Copyright © 2021 Du. All rights reserved.
//

import Foundation
/**
 题目：
 107. 二叉树的层序遍历 II
 给定一个二叉树，返回其节点值自底向上的层序遍历。 （即按从叶子节点所在层到根节点所在的层，逐层从左向右遍历）
 */


/********************解题********************/
class Solution_107 {
    func levelOrderBottom(_ root: TreeNode?) -> [[Int]] {
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
        
        return resultArray.reversed()
    }
}


/********************测试代码********************/
extension Solution_107 {
    func solution_107_test(_ node: TreeNode?) {
        let resultArray = self.levelOrderBottom(node)
        print(resultArray)
    }
}
