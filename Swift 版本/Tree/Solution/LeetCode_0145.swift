//
//  LeetCode_0145.swift
//  LeetCode
//
//  Created by 余杜林 on 2021/1/24.
//  Copyright © 2021 Du. All rights reserved.
//

import Foundation
/**
 题目：
 145. 二叉树的后序遍历
 给你二叉树的根节点 root ，返回它节点值的 后序 遍历。
 */


/********************解题********************/
class Solution_0145 {
    //后序遍历（递归）
    func postorderTraversalWithRecursion(_ root: BinaryTreeClass<String>?, array: inout Array<String>) {
        guard let root = root else {
            return
        }
        
        postorderTraversalWithRecursion(root.left, array: &array)
        postorderTraversalWithRecursion(root.right, array: &array)
        array.append(root.value)
    }
    
    //后序遍历（迭代）
    /**
     思路：
     后序遍历的思路跟前序遍历差不多，前序是『根左右』，后续是『左右根』，只要我们将前序的处理顺序改成『根右左』，然后把最后的数组进行反转，就得到『左右根』的中序遍历了
     */
    
    func postorderTraversalWithIteration(_ root: BinaryTreeClass<String>?, array: inout Array<String>) -> [String] {
        var stack = Stack<BinaryTreeClass<String>?>()
        stack.push(root)
        
        while !stack.isEmpty {
            //先取出栈顶元素
            let top = stack.peek()
            
            //栈顶元素出栈
            let _ = stack.pop()
            
            if top != nil {
                if let topNode = top, let unwrapedValue = topNode?.value {
                    //加入数组中
                    array.append(unwrapedValue)
                }
            }else {
                continue
            }
            
            
            //入栈是先左后右，出栈才能是我们想要的先右后左
            if let topNode = top, let unwrapedValue = topNode {
                //左节点
                stack.push(unwrapedValue.left)
                //右节点
                stack.push(unwrapedValue.right)
            }
        }
        
        //反转数组
        return array.reversed()
    }
    
    /// LeetCode 题解
    func postorderTraversal(_ root: TreeNode?) -> [Int] {
        var stack = Array<TreeNode>()
        var result = Array<Int>()
        guard let root = root else {
            return result
        }
        
        stack.append(root)
        
        while let node = stack.popLast() {
            result.append(node.val)
            
            if let left = node.left {
                stack.append(left)
            }
            
            if let right = node.right {
                stack.append(right)
            }
        }
        return result.reversed()
    }
}

/********************测试代码********************/
extension Solution_0145 {
    func test() {
        ///!!!: 递归遍历测试
        var postorderRecursionArray = Array<String>()
        //["K", "H", "D", "E", "B", "I", "F", "J", "G", "C", "A"]
        self.postorderTraversalWithRecursion(nodeA_class, array: &postorderRecursionArray)
        print("\(type(of: self)): postorderTraversalWithRecursion: \(postorderRecursionArray)")

        ///!!!: 迭代遍历测试
        var postorderIterationArray = Array<String>()
        ////["K", "H", "D", "E", "B", "I", "F", "J", "G", "C", "A"]
        print("\(type(of: self)): postorderTraversalWithIteration: \(self.postorderTraversalWithIteration(nodeA_class, array: &postorderIterationArray))")
        
        print("\(type(of: self)): postorderTraversal: \(postorderTraversal(tree2Root))")
    }
}
