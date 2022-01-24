//
//  LeetCode_0112.swift
//  LeetCode
//
//  Created by Du on 2022/1/22.
//  Copyright © 2022 Du. All rights reserved.
//

import Foundation
/**
 题目：
 112. 路径总和
 给你二叉树的根节点 root 和一个表示目标和的整数 targetSum 。判断该树中是否存在 根节点到叶子节点 的路径，这条路径上所有节点值相加等于目标和 targetSum 。如果存在，返回 true ；否则，返回 false 。
 */


/********************解题********************/
class Solution_0112 {
    // 递归
    func hasPathSum(_ root: TreeNode?, _ targetSum: Int) -> Bool {
        guard let root = root else {
            return false
        }
        
        return traversal(root, targetSum - root.val)
    }
    
    func traversal(_ cur: TreeNode?, _ count: Int) -> Bool {
        if cur?.left == nil && cur?.right == nil && count == 0 {
            return true
        }
        
        if cur?.left == nil && cur?.right == nil {
            return false
        }
        
        // 遇到叶子节点，且 count 减到0，那就返回 true, 这里包含回溯过程
        if let leftNode = cur?.left {
            if traversal(leftNode, count - leftNode.val) {
                return true
            }
        }
        
        if let rightNode = cur?.right {
            if traversal(rightNode, count - rightNode.val) {
                return true
            }
        }
        
        return false
    }
    
    // 递归精简代码
    func hasPathSum_2(_ root: TreeNode?, _ targetSum: Int) -> Bool {
        guard let root = root else {
            return false
        }
        
        /*
         targetSum == root.val 这句的意思是：
         如果来到叶子节点，减剩的 targetSum 等于叶子节点的值，那就是表明路径刚好符合了，就可以返回 true
         */
        if root.left == nil && root.right == nil && targetSum == root.val {
            return true
        }
        
        return hasPathSum_2(root.left, targetSum - root.val) || hasPathSum_2(root.right, targetSum - root.val)
    }
    
    // 迭代
    func hasPathSum_3(_ root: TreeNode?, _ targetSum: Int) -> Bool {
        guard let root = root else {
            return false
        }
        // 元祖是存储着一个节点，而且还记录这到这个节点的路径总和
        var stack = Array<(TreeNode, Int)>()
        stack.append((root, root.val))
        
        /*
         每次循环，都会改变路径总和的值，也就是 node.1 的值，
         这里 targetSum 是不会因为循环而改变，所以只需最后的叶子节点
         记录的路径总和等于 targetSum 就返回 true
        */
        while !stack.isEmpty {
            let node = stack.removeLast()
            
            if node.0.left == nil && node.0.right == nil && targetSum == node.1 {
                return true
            }
            
            if let rightNode = node.0.right {
                stack.append((rightNode, node.1 + rightNode.val))
            }
            
            if let leftNode = node.0.left {
                stack.append((leftNode, node.1 + leftNode.val))
            }
        }
        
        return false
    }
}


/********************测试代码********************/
extension Solution_0112 {
    func test() {
        print(hasPathSum_3(tree3Root, 8))
    }
}
