//
//  LeetCode_144.swift
//  LeetCode
//
//  Created by 余杜林 on 2021/1/24.
//  Copyright © 2021 Du. All rights reserved.
//

import Foundation
/**
 题目：
 144. 二叉树的前序遍历
 给你二叉树的根节点 root ，返回它节点值的 前序 遍历。
 */


/********************解题********************/
class Solution_144 {
    /**
     递归三要素：
     1、确定递归函数的参数和返回值
     2、确定终止条件
     3、确定单层递归的逻辑
     
     公共号文章链接：
     递归：https://mp.weixin.qq.com/s/PwVIfxDlT3kRgMASWAMGhA
     迭代：https://mp.weixin.qq.com/s?__biz=MzUxNjY5NTYxNA==&mid=2247484677&idx=1&sn=e04b4a5baa7a3f6b090947bfa8aea97a&chksm=f9a23654ced5bf421356df70893ef0fa2dab723b83ad9c90a5d4e77f523dd643c85b4e774426&cur_album_id=1485825793120387074&scene=189#rd
     */
    
    
    /********************深度优先遍历********************/
    //前序遍历（递归）
    func preorderTraversalWithRecursion(_ root: BinaryTreeClass<String>?, array: inout Array<String>) {
        guard let root = root else {
            return
        }
        // 单次递归的逻辑处理
        array.append(root.value)
        
        // 递归
        preorderTraversalWithRecursion(root.left, array: &array)
        preorderTraversalWithRecursion(root.right, array: &array)
    }
    
    //前序遍历（迭代）
    /**
     思路：
     因为是前序遍历，所以我们需要先处理根节点（也就是说，先要把根节点放入数组中）；而我们又知道，栈的结构是先进后出，所以如果要保持『根左右』的顺序处理节点，
     那么左右节点的入栈顺序应该是『先右后左』，这样出栈的时候就是我们想要的『先左后右』，然后我们对出栈的数据进行处理（加入数组）就行了。直到栈的元素为空，则返回数组。
     */
    func preorderTraversalWithIteration(_ root: BinaryTreeClass<String>?, array: inout Array<String>) -> [String] {
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
            
            
            //入栈是先右后左，出栈才能是我们想要的先左后右
            if let topNode = top, let unwrapedValue = topNode {
                //右节点
                stack.push(unwrapedValue.right)
                //左节点
                stack.push(unwrapedValue.left)
            }
        }
        
        return array
    }
}


/********************测试代码********************/
extension Solution_144 {
    func solution_144_test() {
        ///!!!: 递归遍历测试
        var preorderRecursionArray = Array<String>()
        //["A", "B", "D", "H", "K", "E", "C", "F", "I", "G", "J"]
        preorderTraversalWithRecursion(nodeA_class, array: &preorderRecursionArray)
        print("\(type(of: self)): preorderTraversalWithRecursion: \(preorderRecursionArray)")

        ///!!!: 迭代遍历测试
        var preorderIterationArray = Array<String>()
        //["A", "B", "D", "H", "K", "E", "C", "F", "I", "G", "J"]
        print("\(type(of: self)): preorderTraversalWithIteration: \(preorderTraversalWithIteration(nodeA_class, array: &preorderIterationArray))")
    }
}


