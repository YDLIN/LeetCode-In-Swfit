//
//  LeetCode_0222.swift
//  LeetCode
//
//  Created by Du on 2022/1/20.
//  Copyright © 2022 Du. All rights reserved.
//

import Foundation
/**
 题目：
 222. 完全二叉树的节点个数
 给你一棵 完全二叉树 的根节点 root ，求出该树的节点个数。
 */


/********************解题********************/
class Solution_0222 {
    // 递归（适用于二叉树）
    func countNodes(_ root: TreeNode?) -> Int {
        guard let root = root else {
            return 0
        }
        
        let leftCount = countNodes(root.left)
        let rightCount = countNodes(root.right)
        
        return leftCount + rightCount + 1
    }
    
    // 使用层序遍历（适用于二叉树）
    func countNodes_2(_ root: TreeNode?) -> Int {
        guard let root = root else {
            return 0
        }

        var queue = Array<TreeNode>()
        queue.append(root)
        var count = 0
        while !queue.isEmpty {
            let size = queue.count
            for _ in 0..<size {
                let node = queue.removeFirst()
                count += 1
                if let lhs = node.left {
                    queue.append(lhs)
                }
                if let rhs = node.right {
                    queue.append(rhs)
                }
            }
        }
        
        return count
    }
    
    // 利用完全二叉树的性质
    func countNodes_3(_ root: TreeNode?) -> Int {
        guard let root = root else {
            return 0
        }
        
        var left = root.left
        var right = root.right
        var leftHeight = 0
        var rightHeight = 0
        
        while left != nil {
            left = left?.left
            leftHeight += 1
        }
        
        while right != nil {
            right = right?.right
            rightHeight += 1
        }
        
        // 能来这里，就是满二叉树
        if leftHeight == rightHeight {
            return 2 << leftHeight - 1 // 注意(2<<1) 相当于2^2
        }
        
        // 如果没有遇到满二叉树，则继续递归左右子树的节点
        return countNodes_3(root.left) + countNodes_3(root.right) + 1
    }
}


/********************测试代码********************/
extension Solution_0222 {
    func test() {
//        print(countNodes_3(tree3Root))
        print(countNodes_3(tree9Root))
//        print(countNodes_3(tree8Root))
    }
}
