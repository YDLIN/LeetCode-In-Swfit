//
//  LeetCode_0589.swift
//  LeetCode
//
//  Created by 余杜林 on 2021/1/27.
//  Copyright © 2021 Du. All rights reserved.
//

import Foundation
/**
 题目：
 589. N叉树的前序遍历
 给定一个 N 叉树，返回其节点值的前序遍历。
 */


/********************解题********************/
class Solution_0589 {
    //前序遍历（递归）
    func preorderTraversalWithRecursion(_ root: NTreeNode?, array: inout Array<Int>) {
        guard let root = root else {
            return
        }
        
        array.append(root.val)
        
        for i in 0..<root.children.count {
            preorderTraversalWithRecursion(root.children[i], array: &array)
        }
    }
    
    //前序遍历（迭代）
    /**
     思路：
     因为是前序遍历，所以我们需要先处理根节点（也就是说，先要把根节点放入数组中）；而我们又知道，栈的结构是先进后出，所以如果要保持『根左右...』的顺序处理节点，
     那么左右节点的入栈顺序应该是『右边->左边』，这样出栈的时候就是我们想要的『左边->右边』，然后我们对出栈的数据进行处理（加入数组）就行了。直到栈的元素为空，则返回数组。
     */
    func preorderTraversalWithIteration(_ root: NTreeNode?, array: inout Array<Int>) -> [Int] {
        var stack = Stack<NTreeNode?>()
        stack.push(root)
        
        while !stack.isEmpty {
            //取出栈顶元素，进行处理
            guard let top = stack.peek(), let unwarpedTop = top else {
                continue
            }
            
            array.append(unwarpedTop.val)
            
            //栈顶元素出栈
            stack.pop()
            
            //入栈是右->左，出栈才能是我们想要的左->右
            _ = unwarpedTop.children.reversed().map{
                stack.push($0)
            }
        }
        
        return array
    }
    
    /// LeetCode 题解
    func preorder(_ root: NTreeNode?) -> [Int] {
        guard let root = root else {
            return []
        }

        var result = [Int]()
        var stack = Array<NTreeNode>()
        stack.append(root)
        
        while let node = stack.popLast() {
            result.append(node.val)
            
            // 入栈从右到左，出栈才是从左到右
            for subNode in node.children.reversed() {
                stack.append(subNode)
            }
        }
        return result
    }
}


/********************测试代码********************/
extension Solution_0589 {
    func test() {
        ///!!!: 递归遍历测试
        var preorderRecursionArray = Array<Int>()
        //[1, 2, 3, 6, 7, 11, 14, 4, 8, 12, 5, 9, 13, 10]
        preorderTraversalWithRecursion(nTree1Root, array: &preorderRecursionArray)
        print("\(type(of: self)): preorderTraversalWithRecursion: \(preorderRecursionArray)")

        ///!!!: 迭代遍历测试
        var preorderIterationArray = Array<Int>()
        //[1, 2, 3, 6, 7, 11, 14, 4, 8, 12, 5, 9, 13, 10]
        print("\(type(of: self)): preorderTraversalWithIteration: \(preorderTraversalWithIteration(nTree2Root, array: &preorderIterationArray))")
        
        print("\(type(of: self)): preorder: \(preorder(nTree1Root))")
    }
}
