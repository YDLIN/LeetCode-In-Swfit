//
//  LeetCode_0104.swift
//  LeetCode
//
//  Created by Du on 2022/1/19.
//  Copyright © 2022 Du. All rights reserved.
//

import Foundation
/**
 题目：
 104. 二叉树的最大深度
 给定一个二叉树，找出其最大深度。
 二叉树的深度为根节点到最远叶子节点的最长路径上的节点数。
 */


/********************解题********************/
class Solution_0104 {
    func maxDepth(_ root: TreeNode?) -> Int {
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
            }
        }
        return depth
    }
}


/********************测试代码********************/
extension Solution_0104 {
    func test() {
        print(maxDepth(tree2Root))
    }
}
