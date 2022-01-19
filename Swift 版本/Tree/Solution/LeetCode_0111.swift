//
//  LeetCode_0111.swift
//  LeetCode
//
//  Created by Du on 2022/1/19.
//  Copyright © 2022 Du. All rights reserved.
//

import Foundation

/**
 题目：
 111. 二叉树的最小深度
 给定一个二叉树，找出其最小深度。
 最小深度是从根节点到最近叶子节点的最短路径上的节点数量。
 */


/********************解题********************/
class Solution_0111 {
    func minDepth(_ root: TreeNode?) -> Int {
        guard let root = root else {
            return 0
        }
        
        var queue = [root]
        var depth = 0
        while !queue.isEmpty {
            let size = queue.count
            depth += 1
            for _ in 0..<size {
                let firstNode = queue.removeFirst()
                
                if let leftNode = firstNode.left {
                    queue.append(leftNode)
                }
                
                if let rightNode = firstNode.right {
                    queue.append(rightNode)
                }
                
                if firstNode.left == nil && firstNode.right == nil {
                    return depth
                }
            }
        }
        return depth
    }
}


/********************测试代码********************/
extension Solution_0111 {
    func test() {
        print(minDepth(tree7Root))
    }
}
