//
//  LeetCode_0404.swift
//  LeetCode
//
//  Created by Du on 2022/1/21.
//  Copyright © 2022 Du. All rights reserved.
//

import Foundation
/**
 题目：
 404. 左叶子之和
 计算给定二叉树的所有左叶子之和。
 */


/********************解题********************/
class Solution_0404 {
    /*
     测试树-10
     [1,3,8,4,6,null,7,null,null,9,5,null,null]
     
                      (1)
                    /     \
                  (3)     (8)
                 /   \       \
               (4)   (6)     (7)
                    /   \
                  (9)   (5)
     
     */
    func sumOfLeftLeaves(_ root: TreeNode?) -> Int {
        guard let root = root else {
            return 0
        }
        
        let leftValue = sumOfLeftLeaves(root.left)
        let rightValue = sumOfLeftLeaves(root.right)
        
        var midValue: Int = 0
        if root.left != nil && root.left?.left == nil && root.left?.right == nil {
            midValue = root.left!.val
        }

        let sum = midValue + leftValue + rightValue
        return sum
    }
    
    func sumOfLeftLeaves_2(_ root: TreeNode?) -> Int {
        guard let root = root else {
            return 0
        }

        var stack = Array<TreeNode>()
        stack.append(root)
        var sum = 0
        
        while !stack.isEmpty {
            let lastNode = stack.removeLast()
            
            if lastNode.left != nil && lastNode.left?.left == nil && lastNode.left?.right == nil {
                sum += lastNode.left!.val
            }
            if let right = lastNode.right {
                stack.append(right)
            }
            if let left = lastNode.left {
                stack.append(left)
            }
        }
        return sum
    }
}


/********************测试代码********************/
extension Solution_0404 {
    func test() {
        print(sumOfLeftLeaves_2(tree6Root))
    }
}
