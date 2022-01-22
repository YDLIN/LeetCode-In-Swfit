//
//  LeetCode_0100.swift
//  LeetCode
//
//  Created by Du on 2022/1/21.
//  Copyright © 2022 Du. All rights reserved.
//

import Foundation
/**
 题目：
 100. 相同的树
 给你两棵二叉树的根节点 p 和 q ，编写一个函数来检验这两棵树是否相同。
 如果两个树在结构上相同，并且节点具有相同的值，则认为它们是相同的。
 */


/********************解题********************/
class Solution_0100 {
    func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
        // 这里是排除了空节点的情况
        if p == nil && q != nil {
            //左节点空，右节点不为空
            return false
        } else if p != nil && q == nil {
            //左节点不为空，右节点为空
            return false
        } else if p == nil && q == nil {
            //左右节点都为空
            return true
        } else if p?.val != q?.val {
            //左右节点都不为空，则比较他们的值是否相等
            return false
        }
        
        // 经过上面的条件筛选之后，下面的情况就是：左右节点都不为空，且左右节点的值是相等的
        // 1、对比二叉树的外侧是否相等
        let outSide = isSameTree(p?.left, q?.left)
        // 2、对比二叉树的内侧是否相等
        let inSide = isSameTree(p?.right, q?.right)
        // 3、只有外侧跟内侧都是对称的，才算真正的对称
        return outSide && inSide
    }
}


/********************测试代码********************/
extension Solution_0100 {
    func test() {
        print(isSameTree(tree3Root, tree2Root))
    }
}
