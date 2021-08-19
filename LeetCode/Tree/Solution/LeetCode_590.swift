//
//  LeetCode_590.swift
//  LeetCode
//
//  Created by Du on 2021/1/29.
//  Copyright © 2021 Du. All rights reserved.
//

import Foundation

/**
 题目：
 590. N叉树的后序遍历
 给定一个 N 叉树，返回其节点值的后序遍历。
 */


/********************解题********************/
class Solution_590 {
    //后序遍历（递归）
    func postorderTraversalWithRecursion(_ root: NTreeNode?, array: inout Array<Int>) {
        guard let root = root else {
            return
        }
        
        root.children.forEach {
            postorderTraversalWithRecursion($0, array: &array)
        }
        
        array.append(root.val)
    }
    
    /**
     思路：
     因为是后序遍历，而我们又知道，栈的结构是先进后出，所以如果要保持『左...右根』的顺序处理节点，
     那么子节点的入栈顺序应该是『右边->左边』，这样出栈的时候就是我们想要的『左边->右边』，然后我们对出栈的数据进行处理（加入数组）就行了。直到栈的元素为空，则返回数组。
     
     假如我们的N叉树是：
               (1)
            /   |   \
        (2)    (3)    (4)
     那么下面是每一次循环，栈跟数组的变化
     初始化：
     stack: [1]
     array: []
     1.
     stack: [2, 3, 4]
     array: [1]
     2.
     stack: [2, 3]
     array: [1, 4]
     3.
     stack: [2]
     array: [1, 4, 3]
     4.
     stack: []
     array: [1, 4, 3, 2]
     5.反转数组
     return:[2, 3, 4, 1]
     */
    //前序遍历（迭代、使用栈）
//    func postorderTraversalWithIteration_1(_ root: NTreeNode?, array: inout Array<Int>) -> [Int] {
//        var stack = Stack<NTreeNode?>()
//        stack.push(root)
//
//        while !stack.isEmpty {
//            //取出栈顶元素，进行处理
//            guard let top = stack.peek(), let unwarpedTop = top else {
//                return []
//            }
//
//            //栈顶元素出栈
//            stack.pop()
//
//            array.append(unwarpedTop.val)
//
//            _ = unwarpedTop.children.map {
//                stack.push($0)
//            }
//        }
//
//        return array.reversed()
//    }
    
    
    //前序遍历（迭代、使用数组）
    func postorderTraversalWithIteration_2(_ root: NTreeNode?, array: inout Array<Int>) -> [Int] {
        guard let rootNode = root else {
            return []
        }
        var stack: [NTreeNode] = [rootNode]
        
        while !stack.isEmpty {
            guard let top = stack.popLast() else {
                return []
            }
            
            array.append(top.val)
            
            _ = top.children.map {
                stack.append($0)
            }
        }
        
        return array.reversed()
    }
}


/********************测试代码********************/
extension Solution_590 {
    func solution_590_test(_ root: NTreeNode?) {
        ///!!!: 递归遍历测试
        var postorderRecursionArray = Array<Int>()
        //[2, 6, 14, 11, 7, 3, 12, 8, 4, 13, 9, 10, 5, 1]
        self.postorderTraversalWithRecursion(root, array: &postorderRecursionArray)
        print("\(type(of: self)): postorderTraversalWithRecursion: \(postorderRecursionArray)")

        ///!!!: 迭代遍历测试
        var postorderIterationArray = Array<Int>()
        //[2, 6, 14, 11, 7, 3, 12, 8, 4, 13, 9, 10, 5, 1]
        print("\(type(of: self)): postorderTraversalWithIteration_2: \(self.postorderTraversalWithIteration_2(root, array: &postorderIterationArray))")
    }
}
