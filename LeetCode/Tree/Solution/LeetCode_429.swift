//
//  LeetCode_429.swift
//  LeetCode
//
//  Created by Du on 2021/1/27.
//  Copyright © 2021 Du. All rights reserved.
//

import Foundation
/**
 题目：
 429. N 叉树的层序遍历
 给定一个 N 叉树，返回其节点值的层序遍历。（即从左到右，逐层遍历）。
 树的序列化输入是用层序遍历，每组子节点都由 null 值分隔（参见示例）。
 */


/********************解题********************/
class Solution_429 {
    func levelOrder(_ root: NTreeNode?) -> [[Int]] {
        guard let rootNode = root else {
            return []
        }
        
        var resultArray = [[Int]]()
        var queue: [NTreeNode] = [rootNode]
        
        while !queue.isEmpty {
            let size = queue.count
            var levelArray = [Int]()
            
            for _ in 0..<size {
                let firstNode = queue.removeFirst()
                levelArray.append(firstNode.val)
                
                _ = firstNode.children.map {
                    queue.append($0)
                }
            }
            resultArray.append(levelArray)
        }
        return resultArray
    }
}


/********************测试代码********************/
extension Solution_429 {
    func solution_429_test(_ node: NTreeNode?) {
        let resultArray = self.levelOrder(node)
        print(resultArray)
    }
}
