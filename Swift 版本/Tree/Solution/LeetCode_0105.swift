//
//  LeetCode_0105.swift
//  LeetCode
//
//  Created by Du on 2022/1/7.
//  Copyright © 2022 Du. All rights reserved.
//

import Foundation
/**
 题目：
 105. 从前序与中序遍历序列构造二叉树
 给定一棵树的前序遍历 preorder 与中序遍历 inorder。请构造二叉树并返回其根节点。
 */


/********************解题********************/
class Solution_0105 {
    func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
        return helper(preorder: preorder,
                      preorderBegin: 0,
                      preorderEnd: preorder.count,
                      inorder: inorder,
                      inorderBegin: 0,
                      inorderEnd: inorder.count)
    }
    
    func helper(preorder: [Int], preorderBegin: Int, preorderEnd: Int, inorder: [Int], inorderBegin: Int, inorderEnd: Int) -> TreeNode? {
        if preorderBegin == preorderEnd {
            return nil
        }
        
        // 前序遍历数组的第一个元素作为分割点
        let rootValue = preorder[preorderBegin]
        let root = TreeNode(rootValue)
        
        
        if preorderEnd - preorderBegin == 1 {
            print("return root: ")
            print(root.val)
            return root
        }
        
        var index = 0 // 从中序遍历数组中找到根节点的下标
        if let ind = inorder.firstIndex(of: rootValue) {
            index = ind
        }
        
        // 递归
        root.left = helper(preorder: preorder,
                           preorderBegin: preorderBegin + 1,
                           preorderEnd: preorderBegin + 1 + index - inorderBegin,
                           inorder: inorder,
                           inorderBegin: inorderBegin,
                           inorderEnd: index)
        root.right = helper(preorder: preorder,
                            preorderBegin: preorderBegin + 1 + index - inorderBegin,
                            preorderEnd: preorderEnd,
                            inorder: inorder,
                            inorderBegin: index + 1,
                            inorderEnd: inorderEnd)
        return root
    }
}


/********************测试代码********************/
extension Solution_0105 {
    func test() {
        let preorder = [1, 2, 4, 8, 12, 5, 3, 6, 9, 10, 7, 11]
        let inorder = [8, 12, 4, 2, 5, 1, 9, 6, 10, 3, 7, 11]
        if let node = buildTree(preorder, inorder) {
            print(node)
        }
    }
}
