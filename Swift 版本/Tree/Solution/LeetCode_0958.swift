//
//  LeetCode_0958.swift
//  LeetCode
//
//  Created by Du on 2022/1/7.
//  Copyright © 2022 Du. All rights reserved.
//

import Foundation

/**
 题目：
 958. 二叉树的完全性检验
 给定一个二叉树，确定它是否是一个完全二叉树。
 */


/********************解题********************/
class Solution_0958 {
    func isCompleteTree(_ root: TreeNode?) -> Bool {
        // 如果节点为空，那返回 false
        guard let node = root else {
            return false
        }
        // 先将头节点放到队列
        var queue = [node]
        /*
         要求节点是否为叶子节点
         false: 不要求节点是叶子节点
         true: 要求节点是叶子节点
         */
        var leaf = false
        while !queue.isEmpty {
            
            let firstNode = queue.removeFirst()
            
            // 如果要求是叶子节点，但是该节点不是叶子节点
            if leaf && (firstNode.left != nil || firstNode.right != nil) {
                return false
            }
            
            if firstNode.left != nil && firstNode.right != nil {
                queue.append(firstNode.left!)
                queue.append(firstNode.right!)
            } else if firstNode.left == nil && firstNode.right != nil {
                return false
            } else if firstNode.left != nil && firstNode.right == nil {
                queue.append(firstNode.left!)
                // 要求是叶子节点，才能是完全二叉树
                leaf = true
            } else { //firstNode.left == nil && firstNode.right == nil
                // 要求是叶子节点，才能是完全二叉树
                leaf = true
            }
        }
        return true
    }
    
    func isCompleteTree2(_ root: TreeNode?) -> Bool {
        // 如果节点为空，那返回 false
        guard let node = root else {
            return false
        }
        // 先将头节点放到队列
        var queue = [node]
        
        /*
         要求节点是否为叶子节点
         false: 不要求节点是叶子节点
         true: 要求节点是叶子节点
         */
        var leaf = false
        while !queue.isEmpty {
            let firstNode = queue.removeFirst()
            
            // 如果要求是叶子节点，但是该节点不是叶子节点
            if leaf && !firstNode.isLeaf() {
                return false
            }
            
            if let leftNode = firstNode.left {
                queue.append(leftNode)
            } else if firstNode.right != nil {
                return false
            }
            
            if let rightNode = firstNode.right {
                queue.append(rightNode)
            } else {
                leaf = true
            }
        }
        return true
    }
}


/********************测试代码********************/
extension Solution_0958 {
    func solution_0958_test(_ node: TreeNode?) {
        if isCompleteTree2(node) {
            print("是完全二叉树")
        } else {
            print("不是完全二叉树")
        }
    }
}
