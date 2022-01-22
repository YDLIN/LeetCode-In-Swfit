//
//  LeetCode_0572.swift
//  LeetCode
//
//  Created by Du on 2022/1/22.
//  Copyright © 2022 Du. All rights reserved.
//

import Foundation
/**
 题目：
 572. 另一棵树的子树
 给你两棵二叉树 root 和 subRoot 。检验 root 中是否包含和 subRoot 具有相同结构和节点值的子树。如果存在，返回 true ；否则，返回 false 。
 二叉树 tree 的一棵子树包括 tree 的某个节点和这个节点的所有后代节点。tree 也可以看做它自身的一棵子树。
 */


/********************解题********************/
class Solution_0572 {
    func isSubtree(_ root: TreeNode?, _ subRoot: TreeNode?) -> Bool {
        // 如果子树为空，肯定是父树的子树
        guard let subRoot = subRoot else {
            return true
        }
        
        // 如果子树不为空，父树是空，那肯定不是父树的子树
        guard let root = root else {
            return false
        }

        /*
         是子树的三种情况：
         1、是父树的左子树
         2、是父树的右子树
         3、跟父树一样
         */
        return isSubtree(root.left, subRoot) || isSubtree(root.right, subRoot) || isSameTree(root, subRoot)
    }
    
    func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
        if p == nil && q == nil {
            return true
        }
        
        if p == nil || q == nil {
            return false
        }
        
        if p?.val != q?.val {
            return false
        }
        
        return isSameTree(p?.left, q?.left) && isSameTree(p?.right, q?.right)
    }
}


/********************测试代码********************/
extension Solution_0572 {
    func test() {
        print(isSubtree(tree3Root, tree2Root))
    }
}
