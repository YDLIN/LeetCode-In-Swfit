//
//  LeetCode_0513.swift
//  LeetCode
//
//  Created by Du on 2022/1/22.
//  Copyright © 2022 Du. All rights reserved.
//

import Foundation
/**
 题目：
 513. 找树左下角的值
 给定一个二叉树的 根节点 root，请找出该二叉树的 最底层 最左边 节点的值。
 假设二叉树中至少有一个节点。
 */


/********************解题********************/
class Solution_0513 {
    func findBottomLeftValue(_ root: TreeNode?) -> Int {
        guard let root = root else {
            return 0
        }
        
        var queue = [root]
        var result = 0
        
        while !queue.isEmpty {
            let size = queue.count
            for i in 0..<size {
                let firstNode = queue.removeFirst()
                
                // 记录每一行的第一个节点，然后不断更新，直到最后一行
                if i == 0 {
                    result = firstNode.val
                }
                
                if let leftNode = firstNode.left {
                    queue.append(leftNode)
                }
                
                if let rightNode = firstNode.right {
                    queue.append(rightNode)
                }
            }
        }
        return result
    }
    
    // 使用前序遍历
    var maxLen = -1
    var maxLeftValue = 0
    func findBottomLeftValue_2(_ root: TreeNode?) -> Int {
        traversal(root, 0)
        return maxLeftValue
    }
    
    func traversal(_ root: TreeNode?, _ deep: Int) {
        guard let root = root else {
            return
        }

        if root.left == nil && root.right == nil {
            if deep > maxLen {
                maxLen = deep
                maxLeftValue = root.val
            }
            return
        }
        
        if root.left != nil {
            traversal(root.left, deep + 1)
        }
        
        if root.right != nil {
            traversal(root.right, deep + 1)
        }
        return
    }
}


/********************测试代码********************/
extension Solution_0513 {
    func test() {
        print(findBottomLeftValue_2(tree8Root))
    }
}
