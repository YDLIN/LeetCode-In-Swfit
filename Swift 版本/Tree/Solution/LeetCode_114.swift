//
//  LeetCode_114.swift
//  LeetCode
//
//  Created by Du on 2021/2/1.
//  Copyright © 2021 Du. All rights reserved.
//

import Foundation
/**
 题目：
 114. 二叉树展开为链表
 给你二叉树的根结点 root ，请你将它展开为一个单链表：

 展开后的单链表应该同样使用 TreeNode ，其中 right 子指针指向链表中下一个结点，而左子指针始终为 null 。
 展开后的单链表应该与二叉树 前序遍历 顺序相同。
 */


/********************解题********************/
class Solution_114 {
    @discardableResult
    func flatten(_ root: TreeNode?) -> TreeNode? {
        guard let root = root else {
            return nil
        }
        
        let leftNode = root.left
        let rightNode = root.right
        
        //先展开左右子树
        flatten(leftNode)
        flatten(rightNode)
        
        //将当前节点的左子树设置为空、将左子树变为右子树
        root.left = nil
        root.right = leftNode
        
        //把原来的右子树放到现在的右子树末端
        var lastRightNode = root
        while lastRightNode.right != nil {
            lastRightNode = lastRightNode.right ?? root
        }
        lastRightNode.right = rightNode
        
        return root
    }
}


/********************测试代码********************/
extension Solution_114 {
    func solution_114_test(_ node: TreeNode?) {
        if let link = self.flatten(node) {
            print(link)
        }
    }
    
    /*
     root: 1,
        1-left = [],
        1-right = [root: 2,
            2-left = [],
            2-right = [root: 4,
                4-left = [],
                4-right = [root: 5,
                    5-left = [],
                    5-right = [root: 3,
                        3-left = [],
                        3-right = [root: 6,
                            6-left = [],
                            6-right = [root: 7,
                                7-left = [],
                                7-right = []]]]]]]
     */
}
