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
    // 层序遍历
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
                
                // 在同一层中，只要左右子节点都没有的话，那当前节点就是叶子节点，到该节点的深度就是最小的
                if firstNode.left == nil && firstNode.right == nil {
                    return depth
                }
            }
        }
        return depth
    }
    
    func minDepth_2(_ root: TreeNode?) -> Int {
        guard let root = root else {
            return 0
        }

        let leftHeight = minDepth_2(root.left)
        let rightHeight = minDepth_2(root.right)
        
        if root.left == nil && root.right != nil {
            return 1 + rightHeight
        }
        
        if root.left != nil && root.right == nil {
            return 1 + leftHeight
        }
        
        // 左右都为空，那leftHeight，rightHeight都为0
        // 左右都不为空，那取leftHeight，rightHeight中的最小者
        return 1 + min(leftHeight, rightHeight)
    }
}


/********************测试代码********************/
extension Solution_0111 {
    func test() {
        print(minDepth(tree7Root))
    }
}
