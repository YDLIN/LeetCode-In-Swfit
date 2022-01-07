//
//  LeetCode_0226.swift
//  LeetCode
//
//  Created by Du on 2021/1/28.
//  Copyright © 2021 Du. All rights reserved.
//

import Foundation
/**
 题目：
 226. 翻转二叉树
 翻转一棵二叉树
 */


/********************解题********************/
class Solution_0226 {
    /********************深度优先遍历********************/
    /// 递归（前序遍历）
    @discardableResult
    func preorderInvertTreeWithRecursion(_ root: TreeNode?) -> TreeNode? {
        guard let root = root else {
            return nil
        }
        
        swap(&root.left, &root.right)
        preorderInvertTreeWithRecursion(root.left)
        preorderInvertTreeWithRecursion(root.right)
        
        return root
    }
    
    /// 递归（类似中序遍历，严格来说，这不是中序遍历）
    @discardableResult
    func postorderInvertTreeWithRecursion(_ root: TreeNode?) -> TreeNode? {
        guard let root = root else {
            return nil
        }
        
        postorderInvertTreeWithRecursion(root.left)
        swap(&root.left, &root.right)
        // 这一步还是遍历左节点，因为上一步把左右节点调换了
        postorderInvertTreeWithRecursion(root.left)
        
        return root
    }
    
    /// 迭代
    func invertTreeWithIteration(_ root: TreeNode?) -> TreeNode? {
        guard let root = root else {
            return nil
        }
        var stack = Stack<TreeNode?>()
        stack.push(root)
        
        while !stack.isEmpty {
            //先取出栈顶元素
            let top = stack.peek()
            
            //栈顶元素出栈
            stack.pop()
            
            if let topNode = top, let unwrapedTop = topNode {
                swap(&unwrapedTop.left, &unwrapedTop.right)
                
                //入栈是先右后左，出栈才能是我们想要的先左后右
                //右节点
                stack.push(unwrapedTop.right)
                //左节点
                stack.push(unwrapedTop.left)
            }
        }
        
        return root
    }
    
    /********************广度优先遍历********************/
    func levelOrder(_ root: TreeNode?) -> TreeNode? {
        guard let rootNode = root else {
            return nil
        }
        
        var queue = [rootNode]
        
        while !queue.isEmpty {
            let size = queue.count
            for _ in 0..<size {
                let firstNode = queue.removeFirst()
                
                swap(&firstNode.left, &firstNode.right)
                
                if let leftNode = firstNode.left {
                    queue.append(leftNode)
                }
                
                if let rightNode = firstNode.right {
                    queue.append(rightNode)
                }
            }
        }
        return root
    }
}

extension Solution_0226 {
    func solution_0226_test(_ root: TreeNode?) {
//        if let invertTree = self.preorderInvertTreeWithRecursion(root) {
//            print("preorderInvertTreeWithRecursion:\n \(invertTree)")
//        }
//        
//        if let invertTree = self.invertTreeWithIteration(root) {
//            print("invertTreeWithIteration:\n \(invertTree)")
//        }
        
        if let invertTree = levelOrder(root) {
            print("levelOrder:\n \(invertTree)")
        }
        
//        if let postorderInvertTree = self.postorderInvertTreeWithRecursion(root) {
//            print("postorderInvertTreeWithRecursion:\n \(postorderInvertTree)")
//        }
    }
}
