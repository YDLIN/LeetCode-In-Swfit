//
//  LeetCode_0104.swift
//  LeetCode
//
//  Created by Du on 2022/1/19.
//  Copyright © 2022 Du. All rights reserved.
//

import Foundation
/**
 题目：
 104. 二叉树的最大深度
 给定一个二叉树，找出其最大深度。
 二叉树的深度为根节点到最远叶子节点的最长路径上的节点数。
 */


/********************解题********************/
class Solution_0104 {
    // 使用层序遍历
    func maxDepth(_ root: TreeNode?) -> Int {
        guard let root = root else {
            return 0
        }
        
        var queue = [root]
        var depth = 0
        while !queue.isEmpty {
            let size = queue.count
            depth += 1
            for _ in 0..<size {
                let firstNode = queue.removeFirst()
                
                if let leftNode = firstNode.left {
                    queue.append(leftNode)
                }
                
                if let rightNode = firstNode.right {
                    queue.append(rightNode)
                }
            }
        }
        return depth
    }
    
    // 使用递归
    func maxDepth_2(_ root: TreeNode?) -> Int {
        print(root!)
        return getDepth(root)
    }
    
    var count = 1
    func getDepth(_ root: TreeNode?) -> Int {
        print("---------第\(count)次递归---------")
        count += 1
        // 终止条件
        guard let root = root else {
            print("输入节点是空，返回0")
            return 0
        }
        print("输入的节点是：\(root.val)")
        
        // 计算左子树的高度
        let leftHight = getDepth(root.left)
        print("root是：\(root.val)，👈🏻的高度是：\(leftHight)")
        // 计算右子树的高度
        let rightHeight = getDepth(root.right)
        print("root是：\(root.val)，👉🏻的高度是：\(rightHeight)")
        // 取两者的最大值，然后加一
        let depth = max(leftHight, rightHeight) + 1
        print("节点：\(root.val)的深度⬇️⬇️⬇️是：\(depth)")
        return depth
    }
}


/********************测试代码********************/
extension Solution_0104 {
    func test() {
        print(maxDepth_2(tree5Root))
    }
}
