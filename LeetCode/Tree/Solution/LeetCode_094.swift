//
//  LeetCode_094.swift
//  LeetCode
//
//  Created by 余杜林 on 2021/1/24.
//  Copyright © 2021 Du. All rights reserved.
//

import Foundation
/**
 题目：
 094. 二叉树的中序遍历
 给你二叉树的根节点 root ，返回它节点值的 中序 遍历。
 */


/********************解题********************/
class Solution_094 {
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
    //中序遍历（递归）
    func inorderTraversalWithRecursion(_ root: BinaryTreeClass<String>?, array: inout Array<String>) {
        if root == nil {
            return
        }
        
        inorderTraversalWithRecursion(root?.left, array: &array)
        if let rootValue = root?.value {
            array.append(rootValue)
        }
        inorderTraversalWithRecursion(root?.right, array: &array)
    }
    
    //中序遍历（迭代）
    /**
     思路：
     因为是中序遍历，所以我们需要先处理左节点（也就是说，先要把左节点放入数组中）；而我们又知道，栈的结构是先进后出，所以如果要保持『左根右』的顺序处理节点，
     那么我们先不处理一开始的根节点，而是将其放入栈中，作为栈底元素。直到这个根节点出栈之前，后面入栈的元素，一定是这个根节点的左子树里面的某个节点。为什么这样说呢？假如我们的中序遍历是这样的『HKDBEAIFCGJ』，且A是根节点，那么在A左边的，一定是他的左子树节点，反之，一定是右子树的节点。
     所以，这里就可以明确入栈的顺序了：根节点首先入栈，然后把根节点的左节点入栈，然后出栈的时候，就是左节点出栈，则处理它（加入数组），继续出栈（这时候是根节点了），加入数组，最后才把右节点入栈，最后处理；
     上面的入栈顺序，是针对根节点的。但是我们深思一下，其实对于每个节点来说，都是这样的处理方法，所以最后的方法就是：
     把访问的节点，入栈，然后继续访问刚刚入栈节点的左节点，直到没有左节点为止，然后就开始出栈，进行处理（加入数组）。每处理一个出栈的元素，我们都要访问该元素的右节点，为什么要去访问右节点？因为该节点都没有左节点了，所以它就是这棵子树的根节点（道理同上），所以先处理它，再去访问右节点，这样才能保证中序遍历的顺序不会出错。
     */
    func inorderTraversalWithIteration(_ root: BinaryTreeClass<String>?, array: inout Array<String>) -> [String] {
        var stack = Stack<BinaryTreeClass<String>?>()
        
        //指向当前元素
        var currentNode = root
        
        while (!stack.isEmpty || currentNode != nil) {
            if currentNode != nil {//用指针来访问节点，一直到没有左子树为止
                stack.push(currentNode)
                currentNode = currentNode?.left
            }else {
                /**
                 没有左子树的节点--出栈；这个时候就要加到数组里面去了，因为这里是中序遍历；然后遍历该节点的右子树；
                 如果右子树也没有的话，或者此时栈不为空，就一直取出栈顶元素，并进行处理（加入数组）
                */
                
                //取出栈顶元素（也就是没有左子树的节点）
                let top = stack.pop()
                
                if let topNode = top, let unwrapedValue = topNode?.value {
                    //加入数组中
                    array.append(unwrapedValue)
                }
                
                if let topNode = top, let unwrapedValue = topNode {
                    //指向右子树
                    currentNode = unwrapedValue.right
                }
            }
        }
        
        return array
    }
}

/********************测试代码********************/
extension Solution_094 {
    func solution_094_test() {
        ///!!!: 递归遍历测试
        var inorderRecursionArray = Array<String>()
        //["H", "K", "D", "B", "E", "A", "I", "F", "C", "G", "J"]
        self.inorderTraversalWithRecursion(nodeA_class, array: &inorderRecursionArray)
        print("\(type(of:self)): inorderTraversalWithRecursion: \(inorderRecursionArray)")

        ///!!!: 迭代遍历测试
        var inorderIterationArray = Array<String>()
        //["H", "K", "D", "B", "E", "A", "I", "F", "C", "G", "J"]
        print("\(type(of: self)): inorderTraversalWithIteration: \(self.inorderTraversalWithIteration(nodeA_class, array: &inorderIterationArray))")
    }
}
