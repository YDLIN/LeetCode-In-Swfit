//
//  LeetCode_101.swift
//  LeetCode
//
//  Created by Du on 2021/2/1.
//  Copyright © 2021 Du. All rights reserved.
//

import Foundation
/**
 题目：
 101. 对称二叉树
 给定一个二叉树，检查它是否是镜像对称的。
 */


/********************解题********************/
class Solution_101 {
    func isSymmetric(_ root: TreeNode?) -> Bool {
        guard let root = root else {
            return true
        }
        return self.compare(node1: root.left, node2: root.right)
    }
    
    //函数的作用，就是用来判断两个节点，是否对称
    func compare(node1: TreeNode?, node2: TreeNode?) -> Bool {
        // 这里是排除了空节点的情况
        if node1 == nil && node2 != nil {
            //左节点空，右节点不为空
            return false
        }else if node1 != nil && node2 == nil {
            //左节点不为空，右节点为空
            return false
        }else if node1 == nil && node2 == nil {
            //左右节点都为空
            return true
        }else if node1?.val != node2?.val {
            //左右节点都不为空，则比较他们的值是否相等
            return false
        }
        
        // 经过上面的条件筛选之后，下面的情况就是：左右节点都不为空，且左右节点的值是相等的
        // 1、对比二叉树的外侧是否相等
        let outSide = compare(node1: node1?.left, node2: node2?.right)
        // 2、对比二叉树的内侧是否相等
        let inSide = compare(node1: node1?.right, node2: node2?.left)
        // 3、只有外侧跟内侧都是对称的，才算真正的对称
        let symmetric = outSide && inSide
        return symmetric
    }
}


/********************测试代码********************/
extension Solution_101 {
    func solution_101_test(_ node: TreeNode?) {
        let isSymmetric = self.isSymmetric(node)
        print(isSymmetric)
    }
}
