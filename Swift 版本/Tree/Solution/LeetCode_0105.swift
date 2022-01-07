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
        if preorder.count == 0 || inorder.count == 0 {
            return nil
        }
        
        let root = TreeNode(preorder.first!);
        var subInorder = [Int]()
        var subPreorder = [Int]()
        for i in inorder {
            if i == root.val {
                if let index = subInorder.firstIndex(of: i) {
                    subPreorder.remove(at: index)
                }
                break
            }
            subInorder.append(i)
        }
        return buildTree(subPreorder, subInorder)
    }
}


/********************测试代码********************/
extension Solution_0105 {
    func solution_0105_test(_ node: TreeNode?) {
        
    }
}
