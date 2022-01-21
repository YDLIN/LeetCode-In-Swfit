//
//  LeetCode_0110.swift
//  LeetCode
//
//  Created by Du on 2022/1/20.
//  Copyright © 2022 Du. All rights reserved.
//

import Foundation
/**
 题目：
 110. 平衡二叉树
 给定一个二叉树，判断它是否是高度平衡的二叉树。
 */


/********************解题********************/
class Solution_0110 {
    func isBalanced(_ root: TreeNode?) -> Bool {
        return getHeight(root) == -1 ? false : true
    }
    
    func getHeight(_ root: TreeNode?) -> Int {
        guard let root = root else {
            return 0
        }
        
        let leftHeight = getHeight(root.left)
        if leftHeight == -1 {
            return -1
        }
        
        let rightHeight = getHeight(root.right)
        if rightHeight == -1 {
            return -1
        }

        var result = 0
        if abs(leftHeight - rightHeight) > 1 {
            result = -1
        } else {
            result = 1 + max(leftHeight, rightHeight)
        }
        return result
    }
}


/********************测试代码********************/
extension Solution_0110 {
    func test() {
        print(isBalanced(tree5Root.left))
    }
}
