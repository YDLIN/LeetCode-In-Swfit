//
//  LeetCode_0113.swift
//  LeetCode
//
//  Created by Du on 2022/1/24.
//  Copyright © 2022 Du. All rights reserved.
//

import Foundation
/**
 题目：
 113. 路径总和 II
 
 给你二叉树的根节点 root 和一个整数目标和 targetSum ，找出所有 从根节点到叶子节点 路径总和等于给定目标和的路径。
 */


/********************解题********************/
class Solution_0113 {
    var result = [[Int]]()
    var path = [Int]()
    func pathSum(_ root: TreeNode?, _ targetSum: Int) -> [[Int]] {
        result.removeAll()
        path.removeAll()
        guard let root = root else {
            return result
        }
        // 根节点必须是路径的开始
        path.append(root.val)
        traversal(root, count: targetSum - root.val)
        return result

    }
    
    func traversal(_ cur: TreeNode?, count: Int) {
        if cur?.left == nil && cur?.right == nil && count == 0 {
            // 遇到了叶子节点且找到了和为targetSum的路径
            if count == 0 {
                result.append(path)
            }
            // 遇到叶子节点而没有找到合适的边，直接返回
            return
        }
        
        if let leftNode = cur?.left {
            path.append(leftNode.val)
            traversal(leftNode, count: count - leftNode.val)// 递归 + 回溯
            path.removeLast()// 回溯
        }
        
        if let rightNode = cur?.right {
            path.append(rightNode.val)
            traversal(rightNode, count: count - rightNode.val)// 递归 + 回溯
            path.removeLast()// 回溯
        }
        return
    }
}


/********************测试代码********************/
extension Solution_0113 {
    func test() {
        print(pathSum(tree11Root, 22))
    }
}
